//
//  TitleTextField.swift
//  Longpops
//
//  Created by martin on 05.04.18.
//

import UIKit

class TitleTextField: TextField {
    override init(tag: Int) {
        super.init(tag: tag)

        self.tag = 0
        self.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("title-textfield-placeholder",
                                                                                                 comment: "TextField."),
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(
                                                                        red: 255/255,
                                                                        green: 255/255,
                                                                        blue: 255/255,
                                                                        alpha: 0.5)])
        self.font = UIFont.systemFont(ofSize: LayoutHandler.getTitleTextFontSizeForDevice(), weight: .regular)
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
