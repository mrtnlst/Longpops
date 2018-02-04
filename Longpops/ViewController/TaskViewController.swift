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
        self.infoButton = UIButton(type: .system)
        self.settingsButton = UIButton(type: .system)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraints()
        self.getCreateReminderButtonCenterX()

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
        self.titleTextField.keyboardAppearance = .dark
        self.titleTextField.backgroundColor = .white
        self.titleTextField.borderStyle = .roundedRect
        self.titleTextField.placeholder = NSLocalizedString("title-textfield-placeholder", comment: "Permission button.")
        self.titleTextField.delegate = self
        self.titleTextField.tag = 0
        self.textFieldContainerView.addSubview(self.titleTextField)
        
        self.successLabel.translatesAutoresizingMaskIntoConstraints = false
        self.successLabel.text = NSLocalizedString("success-label", comment: "Permission button.")
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
        
        self.permissionButton = LayoutHandler.createButton(title: NSLocalizedString("permission-button-title", comment: "Permission button."))
        self.permissionButton.translatesAutoresizingMaskIntoConstraints = false
        self.permissionButton.addTarget(self, action: #selector(TaskViewController.permissionButtonPressed), for: .touchUpInside)
        self.permissionButton.isHidden = true
        self.permissionButtonContainerView.addSubview(self.permissionButton)
        
//        self.permissionButton.setTitle(NSLocalizedString("permission-button-title", comment: "Permission button."), for: .normal)
//        self.permissionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        self.permissionButton.setTitleColor(.white, for: .normal)
//        self.permissionButton.translatesAutoresizingMaskIntoConstraints = false
//        self.permissionButton.addTarget(self, action: #selector(TaskViewController.permissionButtonPressed), for: .touchUpInside)
//        self.permissionButton.titleLabel?.textAlignment = .center
//        self.permissionButton.titleLabel?.numberOfLines = 2
//        self.permissionButton.isHidden = true
//        self.permissionButtonContainerView.addSubview(self.permissionButton)
        
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.setImage(UIImage(named: "InfoButton"), for: .normal)
        self.infoButton.addTarget(self, action: #selector(TaskViewController.infoButtonPressed), for: .touchUpInside)
        self.infoButton.tintColor = .white
        self.headingContainerView.addSubview(self.infoButton)
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.setImage(UIImage(named: "SettingsButton"), for: .normal)
        self.settingsButton.addTarget(self, action: #selector(TaskViewController.settingsButtonPressed), for: .touchUpInside)
        self.settingsButton.tintColor = .white
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
            "createReminderButtonHeight": LayoutHandler.getSaveButtonSizeForDevice(),
            "createReminderButtonWidth": LayoutHandler.getSaveButtonSizeForDevice(),
            "menuButton": 25,
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
                self.textFieldContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.buttonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.textFieldContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.permissionButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.buttonContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                ])
        }
        
        // MARK: Heading Constraints
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[settingsButton(menuButton)]-(>=1)-[headingLabel]-(>=1)-[infoButton(menuButton)]-|",
                                                                                options: .alignAllLastBaseline,
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
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[permissionButton]-(>=1)-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
    }
    
    // MARK: Button Actions
    
    @objc func saveSticky() {
        
        // Create new Reminders item.
        saveNewReminder(stickyText: self.titleTextField.text!)
        
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
        let settingsViewController = SettingsViewController()
        self.present(settingsViewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.saveSticky()
        return true
    }
    
    // MARK: Button Animations
    
    func beginSuccessAnimation() {
        self.createReminderButtonCenterX.constant = -1 * (self.successLabel.frame.width / 2 + 35)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 1.0
        }, completion: {(true) in self.endSuccessAnimation()})
    }
    
    func endSuccessAnimation() {
        self.createReminderButtonCenterX.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, animations:{
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 0
        })
    }
    
    func getCreateReminderButtonCenterX() {
        
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
