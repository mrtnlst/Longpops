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
        
        return deviceType.iPhone6
    }
    
    static func getMultiplierForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
           return 0.0
        }
        if type == deviceType.iPhone6 {
            return 1.0
        }
        
        return 2.0
    }
    
    static func getSaveButtonSizeForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 45
        }
        if type == deviceType.iPhone6Plus {
            return 60
        }

        return 50
    }
    
    static func getBackButtonSizeForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 50
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
 
        return 50
    }
    
    static func getRegularLabelSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 16
        }
        if type == deviceType.iPhone6Plus {
            return 20
        }

        return 18
    }
    
    static func getIntroLabelSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 15
        }
        if type == deviceType.iPhone6Plus {
            return 20
        }
        
        return 18
    }
    
    static func getLinkButtonSizeForDevice() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 17
        }

        return 15
    }

    static func getPageControlMargin() -> CGFloat {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 40
        }
        return 32
    }
    
    static func getIntroPageScrollViewHeightForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return 250
        }
        if type == deviceType.iPhone6 {
            return 300
        }
        return 400
    }
    
    static func getIntroImageSizeForDevice() -> (Int, Int) {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneSE {
            return (100, 200)
        }
        if type == deviceType.iPhone6 {
            return (150, 300)
        }
        return (200, 400)
    }
    
    static func getMarginForDevice() -> Int {
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhone6Plus {
            return 10
        }
        return 8
    }
    
    static func getLayoutOrder() -> String {

        var layoutString = "H:|-(>=1)-[savedImage(imageSize)]-(20)-[dayTextField(smallFieldWidth)][dotLabel1][monthTextField(smallFieldWidth)][dotLabel2][yearTextField(bigFieldWidth)]-(textFieldMargin)-[calendarButton(imageSize)]|"
        
        let regionCode = Locale.current.regionCode
        
        if regionCode == "US" {
            layoutString = "H:|-(>=1)-[savedImage(imageSize)]-(20)-[monthTextField(smallFieldWidth)][dotLabel1][dayTextField(smallFieldWidth)][dotLabel2][yearTextField(bigFieldWidth)]-(textFieldMargin)-[calendarButton(imageSize)]|"
        }
        
        return layoutString
    }
    
    static func getInputViewHeightForDevice(inputToolbarHeight: CGFloat) -> CGFloat {
        
        
        let type = self.getDeviceSize()
        
        if type == deviceType.iPhoneX {
         return 335 - inputToolbarHeight
        }
        if type == deviceType.iPhone6Plus {
            return 270 - inputToolbarHeight
        }
        
        return 260 - inputToolbarHeight
    }
    
    static func getTitleTextFontSizeForDevice() -> CGFloat {
        return 40;
    }
    
    static func getDateTimeTextFontSizeForDevice() -> CGFloat {
        return 30;
    }
}
