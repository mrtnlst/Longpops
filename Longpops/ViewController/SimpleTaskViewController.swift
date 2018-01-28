//
//  ViewController.swift
//  Sticky Reminders
//
//  Created by martin on 12.11.17.
//

import UIKit
import EventKit

class SimpleTaskViewController: TaskViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.headingLabel.text = "Longpops"
        
        self.descriptionLabel.text = NSLocalizedString("description-label-simpletask", comment: "Description label")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "titleTextField": self.titleTextField,
            ]
        
        let metricsDictionary: [String: Any] = [
            "createReminderButtonHeight": 50,
            "createReminderButtonWidth": 50,
            "menuButton": 25
        ]
        
        self.textFieldContainerView.addConstraint(NSLayoutConstraint(item: self.titleTextField,
                                                                     attribute: .centerX,
                                                                     relatedBy: .equal,
                                                                     toItem: self.textFieldContainerView,
                                                                     attribute: .centerX,
                                                                     multiplier: 1.0,
                                                                     constant: 0.0))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


