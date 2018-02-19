//
//  ReminderListButton.swift
//  Longpops
//
//  Created by martin on 19.02.18.
//

import Foundation

import Foundation
import UIKit

class ReminderListButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        // Setting button color and shape.
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.contentEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0)
        
        // Setting button title.
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .highlighted)
        
        // Setting button shadow.
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.layer.borderColor = isHighlighted ? UIColor.lightGray.cgColor : UIColor.white.cgColor
        }
    }
}
