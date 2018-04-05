//
//  DateTimeTextField.swift
//  Longpops
//
//  Created by martin on 05.04.18.
//

import UIKit

class DateTimeTextField: TextField {

    override init(tag: Int) {
        super.init(tag: tag)
        
        self.keyboardType = .numberPad
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: LayoutHandler.getDateTimeTextFontSizeForDevice(), weight: .light)
        self.textColor = .white
        self.backgroundColor = .clear
        self.addTarget(AdvancedTaskViewController(), action: #selector(AdvancedTaskViewController.textFieldEditingDidChange(textField:)), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
