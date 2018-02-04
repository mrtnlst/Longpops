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
            return 50
        }
        if type == deviceType.iPad {
            return 70
        }
        return 40
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
}
