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
}
