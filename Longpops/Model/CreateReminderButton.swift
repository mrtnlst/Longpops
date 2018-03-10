//
//  CreateReminderButton.swift
//  Longpops
//
//  Created by martin on 10.03.18.
//

import UIKit

class CreateReminderButton: UIButton {

    init() {
        super.init(frame: .zero)
        
        self.setImage(UIImage(named: "SaveButton"), for: .normal)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
