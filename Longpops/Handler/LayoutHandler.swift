//
//  LayoutHandler.swift
//  Longpops
//
//  Created by martin on 01.02.18.
//

import Foundation
import UIKit

class LayoutHandler {
    
    enum deviceType {
        case iPhoneSE
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPad
    }
    
    static func getDeviceSize() -> deviceType{
        
        if UIScreen.main.bounds.size.height == 568 {
            return deviceType.iPhoneSE
        }
        if UIScreen.main.bounds.size.height == 736 {
            return deviceType.iPhone6Plus
        }
        if UIScreen.main.bounds.size.height == 812 {
            return deviceType.iPhoneX
        }
        
        if UIScreen.main.bounds.size.height > 812 {
            return deviceType.iPad
        }
        
        return deviceType.iPhone6
    }
    
    static func getMultiplierForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
           return 0.0
        }
        if type == deviceType.iPhone6Plus {
            return 3.0
        }
        if type == deviceType.iPhoneX {
            return 2.0
        }
        if type == deviceType.iPad {
            return 5.0
        }
        return 1.0
    }
    
    static func getSaveButtonSizeForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 60
        }
        if type == deviceType.iPad {
            return 70
        }
        return 50
    }
    
    static func getBackButtonSizeForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 50
        }
        if type == deviceType.iPad {
            return 70
        }
        return 50
    }
    
    static func getHeadingFontSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 40
        }
        if type == deviceType.iPhone6Plus {
            return 55
        }
        if type == deviceType.iPad {
            return 80
        }
        return 50
    }
    
    static func getRegularLabelSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 17
        }
        if type == deviceType.iPhone6Plus {
            return 20
        }
        if type == deviceType.iPad {
            return 22
        }
        return 18
    }
    
    static func getLinkButtonSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 17
        }
        if type == deviceType.iPad {
            return 20
        }
        return 15
    }
    
    static func getMarginForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPad {
            return 200
        }
        if type == deviceType.iPhone6Plus {
            return 10
        }
        return 8
    }
    
    static func getLayoutOrder() -> String {
        
        var layoutString = "H:|-(textFieldMargin)-[hoursTextField(smallFieldWidth)]-(1)-[colonLabel]-(1)-[minutesTextField(smallFieldWidth)]-(>=1)-[dayTextField(smallFieldWidth)]-(1)-[dotLabel1]-(1)-[monthTextField(smallFieldWidth)]-(1)-[dotLabel2]-(1)-[yearTextField(bigFieldWidth)]-(textFieldMargin)-|"
        
        let regionCode = Locale.current.regionCode
        
        if regionCode == "US" {
            layoutString = "H:|-(textFieldMargin)-[hoursTextField(smallFieldWidth)]-(1)-[colonLabel]-(1)-[minutesTextField(smallFieldWidth)]-(>=1)-[monthTextField(smallFieldWidth)]-(1)-[dotLabel1]-(1)-[dayTextField(smallFieldWidth)]-(1)-[dotLabel2]-(1)-[yearTextField(bigFieldWidth)]-(textFieldMargin)-|"
        }
        
        return layoutString
    }
    
    static func createButton(title: String) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.5) , for: .highlighted)
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0)

        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.1
        
        return button
    }
}
