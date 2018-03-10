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

    var navigationItemContainerView: UIView
    var textFieldContainerView: UIView
    var createButtonContainerView: UIView
    var permissionButtonContainerView: UIView
    
    var titleTextField: UITextField
    var createReminderButton: CreateReminderButton
    var permissionButton: UIButton
    var infoButton: UIButton
    var settingsButton: UIButton
    
    override init() {
        self.navigationItemContainerView = UIView()
        self.textFieldContainerView = UIView()
        self.createButtonContainerView = UIView()
        self.permissionButtonContainerView = UIView()
        
        self.titleTextField = UITextField()
        self.createReminderButton = CreateReminderButton()
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkForIntro()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.navigationItemContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.navigationItemContainerView)
        
        self.textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.textFieldContainerView)
        
        self.createButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.createButtonContainerView)
        
        self.permissionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.permissionButtonContainerView)
        
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextField.keyboardAppearance = .dark
        self.titleTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("title-textfield-placeholder", comment: "TextField."),
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.titleTextField.delegate = self
        self.titleTextField.tag = 0
        self.titleTextField.font = UIFont.systemFont(ofSize: LayoutHandler.getTitleTextFontSizeForDevice(), weight: .regular)
        self.titleTextField.textColor = .white
        self.titleTextField.backgroundColor = .clear
        self.textFieldContainerView.addSubview(self.titleTextField)
        
        self.createReminderButton.addTarget(self, action: #selector(TaskViewController.createReminderButtonPressed), for: .touchUpInside)
        self.createButtonContainerView.addSubview(self.createReminderButton)
        
        self.permissionButton = DefaultButton.init(title: NSLocalizedString("permission-button-title", comment: "Permission button."))
        self.permissionButton.translatesAutoresizingMaskIntoConstraints = false
        self.permissionButton.addTarget(self, action: #selector(TaskViewController.permissionButtonPressed), for: .touchUpInside)
        self.permissionButton.isHidden = true
        self.permissionButtonContainerView.addSubview(self.permissionButton)
        
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.setImage(UIImage(named: "InfoButton"), for: .normal)
        self.infoButton.addTarget(self, action: #selector(TaskViewController.infoButtonPressed), for: .touchUpInside)
        self.infoButton.tintColor = .white
        self.navigationItemContainerView.addSubview(self.infoButton)
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.setImage(UIImage(named: "SettingsButton"), for: .normal)
        self.settingsButton.addTarget(self, action: #selector(TaskViewController.settingsButtonPressed), for: .touchUpInside)
        self.settingsButton.tintColor = .white
        self.navigationItemContainerView.addSubview(self.settingsButton)

    }
    
    override func setupConstraints() {
        
        let viewsDictionary: [String: Any] = [
            "navigationItemContainerView": self.navigationItemContainerView,
            "textFieldContainerView": self.textFieldContainerView,
            "createButtonContainerView": self.createButtonContainerView,
            "permissionButtonContainerView": self.permissionButtonContainerView,
            "titleTextField": self.titleTextField,
            "createReminderButton": self.createReminderButton,
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
            self.navigationItemContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.navigationItemContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.textFieldContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.textFieldContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.createButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.createButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.permissionButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.permissionButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.navigationItemContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.textFieldContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.navigationItemContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.createButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.textFieldContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.permissionButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.createButtonContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                ])
        }
        
        // MARK: Navigation item Constraints
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[settingsButton(menuButton)]-(>=1)-[infoButton(menuButton)]-|",
                                                                                options: .alignAllLastBaseline,
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[settingsButton]-|",
                                                                                options: [],
                                                                                metrics: [:],
                                                                                views: viewsDictionary))
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[infoButton]-|",
                                                                                       options: [],
                                                                                       metrics: [:],
                                                                                       views: viewsDictionary))
        
        // MARK: Reminder Button Constraints
        
        self.createButtonContainerView.addConstraint(NSLayoutConstraint(item: self.createReminderButton,
                                                              attribute: .centerX,
                                                              relatedBy: .equal,
                                                              toItem: self.createButtonContainerView,
                                                              attribute: .centerX,
                                                              multiplier: 1.0,
                                                              constant: 0.0))
        
        self.createButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[createReminderButton(createReminderButtonWidth)]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.createButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[createReminderButton(createReminderButtonHeight)]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        // MARK: Permission Button Constraints

        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
    }
    
    // MARK: Button Actions
    
    @objc func createReminderButtonPressed() {
        
        // Create new Reminders item.
        self.saveNewReminder(stickyText: self.titleTextField.text!)
        
        self.disableButtonInteractionWhileAnimating()
        self.titleTextField.text = ""
        self.giveHapticFeedbackOnSave()
        
        AnimationHandler.beginSuccessAnimation(createReminderButton: self.createReminderButton, forwardEnableUserInteraction: { () -> Void in
            self.enableButtonInteractionAfterAnimating()
        })
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
        
        // Check if animation is in progress.
        if self.createReminderButton.isUserInteractionEnabled {
            self.createReminderButtonPressed()
        }
        return true
    }
    
    func giveHapticFeedbackOnSave() {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }
    }
    
    func disableButtonInteractionWhileAnimating() {
        self.createReminderButton.isUserInteractionEnabled = false
    }
    
    func enableButtonInteractionAfterAnimating() {
        self.createReminderButton.isUserInteractionEnabled = true
    }
    
    // MARK: Show Intro
    
    func checkForIntro() {
        let defaults = UserDefaults.standard
        let showIntro = defaults.bool(forKey: "showIntro")
        
        if !showIntro {
            let destinationController = IntroViewController()
            self.present(destinationController, animated: true, completion: nil)
        }
        else {
            self.checkPermission()
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
        catch let error {
            print("Error creating and saving new reminder : \(error)")
        }
    }
    
    @objc override func checkPermission() {
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            if !granted{
                DispatchQueue.main.async {
                    self.createReminderButton.isEnabled = false
                    self.permissionButton.isHidden = false
                    self.titleTextField.isEnabled = false
                }
            }
        }
    }
}
