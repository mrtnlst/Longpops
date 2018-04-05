//
//  TextField.swift
//  Longpops
//
//  Created by martin on 05.04.18.
//

import Foundation
import UIKit

class TextField: UITextField {
    init(tag: Int) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardAppearance = .dark
        self.textColor = .white
        self.backgroundColor = .clear
        self.autocorrectionType = .no
        self.tag = tag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

