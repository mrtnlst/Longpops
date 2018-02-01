//
//  SettingsViewController.swift
//  Longpops
//
//  Created by martin on 20.01.18.
//

import UIKit

class SettingsViewController: TemplateViewController {
    
    private var backButtonContainerView: UIView
    private var startupContainerView: UIView
    private var hapticFeedBackOnJumpContainerView: UIView
    private var hapticFeedBackOnSaveContainerView: UIView
    var backButton: UIButton
    var advancedTaskSwitch: UISwitch
    var advancedTaskLabel: UILabel
    var hapticFeedBackOnJumpLabel: UILabel
    var hapticFeedBackOnJumpSwitch: UISwitch
    var hapticFeedBackOnSaveLabel: UILabel
    var hapticFeedBackOnSaveSwitch: UISwitch
    
    override init() {
        self.backButtonContainerView = UIView()
        self.startupContainerView = UIView()
        self.hapticFeedBackOnJumpContainerView = UIView()
        self.hapticFeedBackOnSaveContainerView = UIView()
        self.backButton = UIButton()
        self.advancedTaskLabel = UILabel()
        self.advancedTaskSwitch = UISwitch()
        self.hapticFeedBackOnJumpLabel = UILabel()
        self.hapticFeedBackOnJumpSwitch = UISwitch()
        self.hapticFeedBackOnSaveLabel = UILabel()
        self.hapticFeedBackOnSaveSwitch = UISwitch()
        
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
        
        self.startupContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.startupContainerView)
        
        self.hapticFeedBackOnJumpContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.hapticFeedBackOnJumpContainerView)
        
        self.hapticFeedBackOnSaveContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.hapticFeedBackOnSaveContainerView)
        
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
        self.advancedTaskLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .medium)
        self.advancedTaskLabel.lineBreakMode = .byWordWrapping
        self.advancedTaskLabel.numberOfLines = 0
        self.advancedTaskLabel.textAlignment = .left
        self.startupContainerView.addSubview(self.advancedTaskLabel)
        
        self.advancedTaskSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.advancedTaskSwitch.onTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.advancedTaskSwitch.addTarget(self, action: #selector(advancedTaskSwitchToggled), for: .valueChanged)
        self.startupContainerView.addSubview(self.advancedTaskSwitch)
        
        self.hapticFeedBackOnJumpLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.hapticFeedBackOnJumpLabel.text = NSLocalizedString("settings-label-haptic-jump", comment: "Haptic Feedback label.")
        self.hapticFeedBackOnJumpLabel.textColor = .white
        self.hapticFeedBackOnJumpLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .medium)
        self.hapticFeedBackOnJumpLabel.lineBreakMode = .byWordWrapping
        self.hapticFeedBackOnJumpLabel.numberOfLines = 0
        self.hapticFeedBackOnJumpLabel.textAlignment = .left
        self.hapticFeedBackOnJumpContainerView.addSubview(self.hapticFeedBackOnJumpLabel)
        
        self.hapticFeedBackOnJumpSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.hapticFeedBackOnJumpSwitch.onTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.hapticFeedBackOnJumpSwitch.addTarget(self, action: #selector(self.hapticFeedbackOnJumpSwitchToggled), for: .valueChanged)
        self.hapticFeedBackOnJumpContainerView.addSubview(self.hapticFeedBackOnJumpSwitch)
        
        self.hapticFeedBackOnSaveLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.hapticFeedBackOnSaveLabel.text = NSLocalizedString("settings-label-haptic-save", comment: "Haptic Feedback label.")
        self.hapticFeedBackOnSaveLabel.textColor = .white
        self.hapticFeedBackOnSaveLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .medium)
        self.hapticFeedBackOnSaveLabel.lineBreakMode = .byWordWrapping
        self.hapticFeedBackOnSaveLabel.numberOfLines = 0
        self.hapticFeedBackOnSaveLabel.textAlignment = .left
        self.hapticFeedBackOnSaveContainerView.addSubview(self.hapticFeedBackOnSaveLabel)
        
        self.hapticFeedBackOnSaveSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.hapticFeedBackOnSaveSwitch.onTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.hapticFeedBackOnSaveSwitch.addTarget(self, action: #selector(self.hapticFeedbackOnSaveSwitchToggled), for: .valueChanged)
        self.hapticFeedBackOnSaveContainerView.addSubview(self.hapticFeedBackOnSaveSwitch)
        
        let defaults = UserDefaults.standard
        self.advancedTaskSwitch.isOn = defaults.bool(forKey: "advancedTask")
        self.hapticFeedBackOnJumpSwitch.isOn = defaults.bool(forKey: "feedbackOnJump")
        self.hapticFeedBackOnSaveSwitch.isOn = defaults.bool(forKey: "feedbackOnSave")

    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "backButtonContainerView": self.backButtonContainerView,
            "backButton": self.backButton,
            "advancedTaskSwitch": self.advancedTaskSwitch,
            "advancedTaskLabel": self.advancedTaskLabel,
            "hapticFeedBackOnJumpSwitch": self.hapticFeedBackOnJumpSwitch,
            "hapticFeedBackOnJumpLabel": self.hapticFeedBackOnJumpLabel,
            "hapticFeedBackOnJumpContainerView": self.hapticFeedBackOnJumpContainerView,
            "hapticFeedBackOnSaveSwitch": self.hapticFeedBackOnSaveSwitch,
            "hapticFeedBackOnSaveLabel": self.hapticFeedBackOnSaveLabel,
            "hapticFeedBackOnSaveContainerView": self.hapticFeedBackOnSaveContainerView,
            ]
        
        let metricsDictionary: [String: Any] = [
            "backButtonSize": LayoutHandler.getSaveButtonSizeForDevice(),
            "margin": LayoutHandler.getMarginForDevice(),
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.startupContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.startupContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.hapticFeedBackOnJumpContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.hapticFeedBackOnJumpContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.hapticFeedBackOnSaveContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.hapticFeedBackOnSaveContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            NSLayoutConstraint.activate([
                self.startupContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                self.hapticFeedBackOnJumpContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.startupContainerView.bottomAnchor, multiplier: 1.0),
                self.hapticFeedBackOnSaveContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.hapticFeedBackOnJumpContainerView.bottomAnchor, multiplier: 1.0),
                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.hapticFeedBackOnSaveContainerView.bottomAnchor, multiplier: 1.0),
                ])
        }

        // MARK: Switch Constraints.
        self.startupContainerView.addConstraint(NSLayoutConstraint(item: self.advancedTaskSwitch,
                                                                      attribute: .centerY,
                                                                      relatedBy: .equal,
                                                                      toItem: self.startupContainerView,
                                                                      attribute: .centerY,
                                                                      multiplier: 1.0,
                                                                      constant: 0.0))
        
        self.startupContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[advancedTaskLabel]-[advancedTaskSwitch]-(margin)-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.startupContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[advancedTaskLabel]-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.startupContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[advancedTaskSwitch]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
       
        // Haptic Feedback on jump.
        self.hapticFeedBackOnJumpContainerView.addConstraint(NSLayoutConstraint(item: self.hapticFeedBackOnJumpSwitch,
                                                                  attribute: .centerY,
                                                                  relatedBy: .equal,
                                                                  toItem: self.hapticFeedBackOnJumpContainerView,
                                                                  attribute: .centerY,
                                                                  multiplier: 1.0,
                                                                  constant: 0.0))
        
        self.hapticFeedBackOnJumpContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[hapticFeedBackOnJumpLabel]-[hapticFeedBackOnJumpSwitch]-(margin)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.hapticFeedBackOnJumpContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hapticFeedBackOnJumpLabel]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.hapticFeedBackOnJumpContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[hapticFeedBackOnJumpSwitch]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        // Haptic Feedback on jump.
        self.hapticFeedBackOnSaveContainerView.addConstraint(NSLayoutConstraint(item: self.hapticFeedBackOnSaveSwitch,
                                                                                attribute: .centerY,
                                                                                relatedBy: .equal,
                                                                                toItem: self.hapticFeedBackOnSaveContainerView,
                                                                                attribute: .centerY,
                                                                                multiplier: 1.0,
                                                                                constant: 0.0))
        
        self.hapticFeedBackOnSaveContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[hapticFeedBackOnSaveLabel]-[hapticFeedBackOnSaveSwitch]-(margin)-|",
                                                                                             options: [],
                                                                                             metrics: metricsDictionary,
                                                                                             views: viewsDictionary))
        
        self.hapticFeedBackOnSaveContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hapticFeedBackOnSaveLabel]-|",
                                                                                             options: [],
                                                                                             metrics: metricsDictionary,
                                                                                             views: viewsDictionary))
        
        self.hapticFeedBackOnSaveContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[hapticFeedBackOnSaveSwitch]-(>=1)-|",
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
    
    @objc func hapticFeedbackOnJumpSwitchToggled() {
        let defaults = UserDefaults.standard
        defaults.set(self.hapticFeedBackOnJumpSwitch.isOn, forKey: "feedbackOnJump")
    }
    
    @objc func hapticFeedbackOnSaveSwitchToggled() {
        let defaults = UserDefaults.standard
        defaults.set(self.hapticFeedBackOnSaveSwitch.isOn, forKey: "feedbackOnSave")
    }
}
