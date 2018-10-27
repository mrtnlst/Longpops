//
//  DefaultButton.swift
//  Longpops
//
//  Created by martin on 05.02.18.
//

import Foundation
import UIKit

class DefaultButton: UIButton {
    
    let brightBlue = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
    let highlightedBlue = UIColor(red: 67.0/255, green: 109.0/255, blue: 133.0/255, alpha: 1.0)
    let highlightedGray = UIColor(red: 135.0/255, green: 136.0/255, blue: 136.0/255, alpha: 1.0)
    
    init(title: String) {
        super.init(frame: .zero)
        
        // Setting button color and shape.
        self.backgroundColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.layer.cornerRadius = 5
        self.contentEdgeInsets = UIEdgeInsets.init(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        
        // Setting button title.
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor( highlightedGray, for: .highlighted)
       
        // Setting button shadow.
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.1
        
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? highlightedBlue : brightBlue
        }
    }
}
