//
//  SettingsViewController.swift
//  Longpops
//
//  Created by martin on 20.01.18.
//

import UIKit

class SettingsViewController: TemplateViewController {
    
    private var backButtonContainerView: UIView
    private var switchContainerView: UIView
    var backButton: UIButton
    var advancedTaskSwitch: UISwitch
    var advancedTaskLabel: UILabel
    
    override init() {
        self.backButtonContainerView = UIView()
        self.switchContainerView = UIView()
        self.backButton = UIButton()
        self.advancedTaskLabel = UILabel()
        self.advancedTaskSwitch = UISwitch()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.headingLabel.text = NSLocalizedString("heading-label-settings", comment: "Heading label.")
        self.descriptionLabel.text = NSLocalizedString("description-label-settings", comment: "Description label.")
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.switchContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.switchContainerView)
        
        self.backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        self.backButton.layer.shadowColor = UIColor.black.cgColor
        self.backButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backButton.layer.shadowOpacity = 0.2
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.addTarget(self, action: #selector(SettingsViewController.backButtonPressed), for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
        
        self.advancedTaskLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.advancedTaskLabel.text = NSLocalizedString("settings-label-startup-screen", comment: "Settings label.")
        self.advancedTaskLabel.textColor = .white
        self.advancedTaskLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.advancedTaskLabel.lineBreakMode = .byWordWrapping
        self.advancedTaskLabel.numberOfLines = 0
        self.advancedTaskLabel.textAlignment = .left
        self.switchContainerView.addSubview(self.advancedTaskLabel)
        
        self.advancedTaskSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.advancedTaskSwitch.onTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.advancedTaskSwitch.addTarget(self, action: #selector(advancedTaskSwitchToggled), for: .valueChanged)
        self.switchContainerView.addSubview(self.advancedTaskSwitch)
        
        let defaults = UserDefaults.standard
        self.advancedTaskSwitch.isOn = defaults.bool(forKey: "advancedTask")

    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "backButtonContainerView": self.backButtonContainerView,
            "backButton": self.backButton,
            "advancedTaskSwitch": self.advancedTaskSwitch,
            "advancedTaskLabel": self.advancedTaskLabel,
            ]
        
        let metricsDictionary: [String: Any] = [
            "backButtonSize": 50,
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.switchContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.switchContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            NSLayoutConstraint.activate([
                self.switchContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.switchContainerView.bottomAnchor, multiplier: 1.0),
                ])
            
        }

        self.switchContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[advancedTaskLabel]-[advancedTaskSwitch]-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.switchContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[advancedTaskLabel]-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.switchContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[advancedTaskSwitch]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        // MARK: Back Button Constraints
        self.backButtonContainerView.addConstraint(NSLayoutConstraint(item: self.backButton,
                                                                      attribute: .centerX,
                                                                      relatedBy: .equal,
                                                                      toItem: self.backButtonContainerView,
                                                                      attribute: .centerX,
                                                                      multiplier: 1.0,
                                                                      constant: 0.0))
        
        self.backButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[backButton(backButtonSize)]-(>=1)-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.backButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[backButton(backButtonSize)]-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: {
            if self.advancedTaskSwitch.isOn {
                UIApplication.shared.delegate?.window??.rootViewController = AdvancedTaskViewController()
            }
            else {
                UIApplication.shared.delegate?.window??.rootViewController = SimpleTaskViewController()
            }
        })
    }
    
    @objc func advancedTaskSwitchToggled() {
        let defaults = UserDefaults.standard
        defaults.set(self.advancedTaskSwitch.isOn, forKey: "advancedTask")
    }
}
