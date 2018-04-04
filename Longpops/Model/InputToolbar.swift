//
//  InputToolbar.swift
//  Longpops
//
//  Created by martin on 04.04.18.
//

import UIKit

class InputToolbar: UIToolbar {

    init() {
        super.init(frame: .zero)
        
        self.barStyle = .blackTranslucent
        self.sizeToFit()
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("done-button-input-toolbar", comment: "Done button title"),
                                         style: .plain,
                                         target: AdvancedTaskViewController(),
                                         action: #selector(AdvancedTaskViewController.saveButtonPressed))
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24.0, weight: .regular)], for: .normal)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24.0, weight: .regular)], for: .highlighted)
        doneButton.tintColor = UIColor.white
        doneButton.setTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: -20.0), for: .default)
        
        let forwardButton  = UIBarButtonItem(image: UIImage(named: "ForwardButton"), style: .plain, target: AdvancedTaskViewController(), action: #selector(AdvancedTaskViewController.keyboardForwardButton))
        forwardButton.tintColor = UIColor.white
        
        let backwardButton  = UIBarButtonItem(image: UIImage(named: "BackwardButton"), style: .plain, target: AdvancedTaskViewController(), action: #selector(AdvancedTaskViewController.keyboardBackwardButton))
        backwardButton.tintColor = UIColor.white
        
        self.setItems([fixedSpaceButton, fixedSpaceButton, flexibleSpaceButton, backwardButton, forwardButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
