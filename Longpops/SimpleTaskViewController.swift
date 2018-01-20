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
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.headingLabel.text = "Longpops"
        
        self.descriptionLabel.text = "Create overdue Reminders, that stay on your lock screen."
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


