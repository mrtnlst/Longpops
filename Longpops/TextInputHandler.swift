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
    
    static func jumpToNextTextField(tag: Int) -> Int {
        if tag > 4 {
            return 0
        }
        else {
            return tag + 1
        }
    }
    
    static func jumpToPreviousTextField(tag: Int) -> Int {
        if tag < 1 {
            return 5
        }
        else {
            return tag - 1
        }
    }
    
    static func isDateComponentCorrect(textField: UITextField) -> Bool {
        
        // Validity check os only executed if required digits are reached.
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
                if getNumberOfDigits(string: textField.text!) < 2 {
                    return true
                }
                else if input > 31 || input < 1 {
                    return false
                }
            case 4:
                if getNumberOfDigits(string: textField.text!) < 2 {
                    return true
                }
                else if input > 12 || input < 1 {
                    return false
                }
            case 5:
                if getNumberOfDigits(string: textField.text!) < 4 {
                    return true
                }
                else if input < DateTimeHandler.getCurrentDate().2 {
                    return false
                }
            default:
                break
            }
        }
        return true
    }
}
