//
//  TaskViewController.swift
//  Longpops
//
//  Created by martin on 20.01.18.
//

import Foundation
import UIKit
import EventKit

class TaskViewController: TemplateViewController {

    var textFieldContainerView: UIView
    var buttonContainerView: UIView
    var permissionButtonContainerView: UIView
    
    var titleTextField: UITextField
    var createReminderButton: UIButton
    var createReminderButtonCenterX: NSLayoutConstraint
    var successLabel: UILabel
    var permissionButton: UIButton
    var infoButton: UIButton
    var settingsButton: UIButton
    var eventStore: EKEventStore!
    
    override init() {
        self.textFieldContainerView = UIView()
        self.buttonContainerView = UIView()
        self.permissionButtonContainerView = UIView()
        
        self.titleTextField = UITextField()
        self.createReminderButton = UIButton()
        self.createReminderButtonCenterX = NSLayoutConstraint()
        self.successLabel = UILabel()
        self.permissionButton = UIButton(type: .system)
        self.infoButton = UIButton(type: .infoLight)
        self.settingsButton = UIButton()
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 97/255, alpha: 1.0)
        self.setupViews()
        self.setupConstraints()
        
        self.eventStore = EKEventStore()
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            if !granted{
                DispatchQueue.main.async {
                    self.createReminderButton.isEnabled = false
                    self.titleTextField.isEnabled = false
                    self.permissionButton.isHidden = false
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleTextField.becomeFirstResponder()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.textFieldContainerView)
        
        self.buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.buttonContainerView)
        
        self.permissionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.permissionButtonContainerView)
        
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextField.backgroundColor = .white
        self.titleTextField.borderStyle = .roundedRect
        self.titleTextField.placeholder = "Remind me of .."
        self.titleTextField.delegate = self
        self.textFieldContainerView.addSubview(self.titleTextField)
        
        self.successLabel.translatesAutoresizingMaskIntoConstraints = false
        self.successLabel.text = "Saved!"
        self.successLabel.textColor = .white
        self.successLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.successLabel.alpha = 0
        self.buttonContainerView.addSubview(self.successLabel)
        
        self.createReminderButton.setImage(UIImage(named: "SaveButton"), for: .normal)
        self.createReminderButton.layer.shadowColor = UIColor.black.cgColor
        self.createReminderButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.createReminderButton.layer.shadowOpacity = 0.2
        self.createReminderButton.translatesAutoresizingMaskIntoConstraints = false
        self.createReminderButton.addTarget(self, action: #selector(TaskViewController.saveSticky), for: .touchUpInside)
        self.buttonContainerView.addSubview(self.createReminderButton)
        
        self.permissionButton.setTitle("Open Settings to enable access to Reminders!", for: .normal)
        self.permissionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.permissionButton.setTitleColor(.white, for: .normal)
        self.permissionButton.translatesAutoresizingMaskIntoConstraints = false
        self.permissionButton.addTarget(self, action: #selector(TaskViewController.permissionButtonPressed), for: .touchUpInside)
        self.permissionButton.titleLabel?.textAlignment = .center
        self.permissionButton.titleLabel?.numberOfLines = 2
        self.permissionButton.isHidden = true
        self.permissionButtonContainerView.addSubview(self.permissionButton)
        
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.addTarget(self, action: #selector(TaskViewController.infoButtonPressed), for: .touchUpInside)
        self.infoButton.tintColor = .white
        self.headingContainerView.addSubview(self.infoButton)
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.setImage(UIImage(named: "Browser"), for: .normal)
        self.settingsButton.addTarget(self, action: #selector(TaskViewController.settingsButtonPressed), for: .touchUpInside)
        self.headingContainerView.addSubview(self.settingsButton)
    }
    
    override func setupConstraints() {
        
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "textFieldContainerView": self.textFieldContainerView,
            "buttonContainerView": self.buttonContainerView,
            "permissionButtonContainerView": self.permissionButtonContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,
            "titleTextField": self.titleTextField,
            "createReminderButton": self.createReminderButton,
            "successLabel": self.successLabel,
            "permissionButton": self.permissionButton,
            "infoButton": self.infoButton,
            "settingsButton": self.settingsButton,
            ]
        
        let metricsDictionary: [String: Any] = [
            "createReminderButtonHeight": 50,
            "createReminderButtonWidth": 50,
            "menuButton": 25
        ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.textFieldContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.textFieldContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.buttonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.buttonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.permissionButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.permissionButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            NSLayoutConstraint.activate([
                self.textFieldContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                
                self.buttonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.textFieldContainerView.bottomAnchor, multiplier: 1.0),
                
                self.permissionButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.buttonContainerView.bottomAnchor, multiplier: 1.0),
                ])
        }
        
        // MARK: Heading Constraints
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[settingsButton(menuButton)]-(>=1)-[headingLabel]-(>=1)-[infoButton(menuButton)]-|",
                                                                                options: .alignAllLastBaseline,
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        // MARK: Textfields Constraints
        
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
        
        // MARK: Reminder Button Constraints
        
        self.buttonContainerView.addConstraint(NSLayoutConstraint(item: self.createReminderButton,
                                                                  attribute: .centerX,
                                                                  relatedBy: .equal,
                                                                  toItem: self.buttonContainerView,
                                                                  attribute: .centerX,
                                                                  multiplier: 1.0,
                                                                  constant: 0.0))
        
        self.buttonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[createReminderButton(createReminderButtonWidth)]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.buttonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[createReminderButton(createReminderButtonHeight)]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.buttonContainerView.addConstraint(NSLayoutConstraint(item: self.successLabel,
                                                                  attribute: .centerX,
                                                                  relatedBy: .equal,
                                                                  toItem: self.buttonContainerView,
                                                                  attribute: .centerX,
                                                                  multiplier: 1.0,
                                                                  constant: 0.0))
        
        self.buttonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[successLabel]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.buttonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[successLabel]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        // MARK: Permission Button Constraints
        
        self.permissionButtonContainerView.addConstraint(NSLayoutConstraint(item: self.permissionButton,
                                                                            attribute: .centerX,
                                                                            relatedBy: .equal,
                                                                            toItem: self.permissionButtonContainerView,
                                                                            attribute: .centerX,
                                                                            multiplier: 1.0,
                                                                            constant: 0.0))
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[permissionButton]-(>=1)-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
    }
    
    // MARK: Button Actions
    
    @objc func saveSticky() {
        
        // Create new Reminders item.
        saveNewReminder(stickyText: self.titleTextField.text!)
        
        // Get reference for createReminderButton centerX constraint in superView.
        for constraint in self.createReminderButton.superview!.constraints {
            if let button = constraint.firstItem as? UIButton {
                if button == self.createReminderButton {
                    if constraint.firstAttribute == .centerX {
                        self.createReminderButtonCenterX = constraint
                    }
                }
            }
        }
        
        self.titleTextField.text = ""
        beginSuccessAnimation()
    }
    
    @objc func permissionButtonPressed() {
        let scheme:String = UIApplicationOpenSettingsURLString
        if let url = URL(string: scheme) {
            if #available(iOS 10.0, *) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {(success) in
                                                print("Open \(scheme): \(success)")})
                }
            }
            else {
                DispatchQueue.main.async {
                    let success = UIApplication.shared.openURL(url)
                    print("Open \(scheme): \(success)")
                }
            }
        }
    }
    
    @objc func infoButtonPressed() {
        let aboutViewController = AboutViewController()
        self.present(aboutViewController, animated: true, completion: nil)
    }
    
    @objc func settingsButtonPressed() {
        print("Settings")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.saveSticky()
        return true
    }
    
    // MARK: Button Animations
    
    fileprivate func beginSuccessAnimation() {
        self.createReminderButtonCenterX.constant = -1 * (self.successLabel.frame.width / 2 + 35)
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 1.0
        }, completion: {(true) in self.endSuccessAnimation()})
    }
    
    fileprivate func endSuccessAnimation() {
        self.createReminderButtonCenterX.constant = 0
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0.5, animations:{
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 0
        })
    }
    
    // MARK: Create Reminder
    
    func saveNewReminder(stickyText: String) {
        let reminder = EKReminder(eventStore:self.eventStore)
        var date = Date()
        date.addTimeInterval(5)
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
        let components = Calendar.current.dateComponents(unitFlags, from: date)
        
        reminder.title = stickyText
        reminder.dueDateComponents = components
        reminder.addAlarm(EKAlarm.init(absoluteDate: date))
        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
        
        do {
            try self.eventStore.save(reminder, commit: true)
            print("Saved")
        }
        catch {
            print("Error creating and saving new reminder : \(error)")
        }
    }
}