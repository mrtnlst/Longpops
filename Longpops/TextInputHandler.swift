//
//  TextInputHandler.swift
//  Longpops
//
//  Created by martin on 21.01.18.
//

import Foundation
import UIKit

class TextInputHandler {
    
    static func getNumberOfDigits(string: String) -> Int {
        return string.count
    }
    
    static func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    static func shouldSkipToNextTextField(textField: UITextField) -> Bool {
        let digits = getNumberOfDigits(string: textField.text!)
        
        switch textField.tag {
        case 1...4:
            if digits > 1 {
                return true
            }
        case 5:
            if digits > 3 {
                return true
            }
        default:
            break
        }
        return false
    }
    
    static func jumpToTextField(tag: Int) -> Int {
        if tag > 4 {
            return 0
        }
        else {
            return tag + 1
        }
    }
    
    static func isDateComponentCorrect(textField: UITextField) -> Bool {
        
        // Only check yearTextField, if it's fully typed in.
        if textField.tag == 5 && getNumberOfDigits(string: textField.text!) < 4 {
            return true
        }
        
        if let input = Int(textField.text!) {
            switch textField.tag {
            case 1:
                if input > 23 {
                    return false
                }
            case 2:
                if input > 59 {
                    return false
                }
            case 3:
                if input > 31 || input < 1 {
                    return false
                }
            case 4:
                if input > 12 || input < 1 {
                    return false
                }
            case 5: if input < 2017 {
                return false
                }
            default:
                break
            }
        }
        return true
    }
}
