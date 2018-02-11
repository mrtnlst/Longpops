//
//  AnimationHandler.swift
//  Longpops
//
//  Created by martin on 11.02.18.
//

import Foundation
import UIKit

class AnimationHandler {
    
    static func beginSuccessAnimation(createReminderButton: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            createReminderButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: .curveEaseInOut,
                       animations: {createReminderButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)},
                       completion: nil)
        
        UIView.transition(with: createReminderButton as UIView,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: {createReminderButton.setImage(UIImage(named: "SuccessButton"), for: .normal)},
                          completion:  {(true) in self.endSuccessAnimation(createReminderButton: createReminderButton)})
    }
    
    static func endSuccessAnimation(createReminderButton: UIButton) {
        
        UIView.animate(withDuration: 0.75, delay: 0.5, options: .curveEaseInOut, animations: {
            UIView.transition(with: createReminderButton as UIView,
                              duration: 0.75,
                              options: .transitionCrossDissolve,
                              animations: {createReminderButton.setImage(UIImage(named: "SaveButton"), for: .normal)},
                              completion: nil)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       animations: {createReminderButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)},
                       completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: .curveEaseInOut,
                       animations: {createReminderButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)},
                       completion: nil)
    }
}
