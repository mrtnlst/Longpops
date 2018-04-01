//
//  AnimationHandler.swift
//  Longpops
//
//  Created by martin on 11.02.18.
//

import Foundation
import UIKit

class AnimationHandler {
    
    static func beginSuccessAnimation(savedImage: UIImageView, forwardEnableUserInteraction: @escaping () -> ()) {
        
        UIView.transition(with: savedImage as UIView,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {savedImage.alpha = 1.0},
                          completion: {(true) in
                            UIView.animate(withDuration: 0.75,
                                           delay: 0,
                                           options: .curveEaseInOut,
                                           animations: {
                                UIView.transition(with: savedImage as UIView,
                                                  duration: 0.75,
                                                  options: .transitionCrossDissolve,
                                                  animations: {savedImage.alpha = 0.0},
                                                  completion: nil)
                            }, completion: {(true) in
                                forwardEnableUserInteraction()})
        })

        UIView.animate(withDuration: 0.5) {
            savedImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: .curveEaseInOut,
                       animations: {savedImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)},
                       completion: nil)
        
    }
}
