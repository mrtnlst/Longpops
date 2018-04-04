//
//  AlertHandler.swift
//  Longpops
//
//  Created by martin on 04.04.18.
//

import Foundation

import UIKit

class AlertHandler {
    
    static func createErrorAlert() -> UIAlertController {
        // Create an alert.
        let alert = UIAlertController(title: NSLocalizedString("alert-title", comment: "Alert title."), message: NSLocalizedString("alert-message", comment: "Alert message."), preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: NSLocalizedString("alert-button", comment: "Alert button."), style: .default)
        
        alert.addAction(continueAction)
        
        return alert
    }
}
