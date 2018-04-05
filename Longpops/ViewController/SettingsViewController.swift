//
//  SettingsViewController.swift
//  Longpops
//
//  Created by martin on 20.01.18.
//

import UIKit
import EventKit

class SettingsViewController: TemplatePageViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var backButtonContainerView: UIView
    var reminderListContainerView: UIView
    var showIntroButtonContainerView: UIView
    var saveWithAlarmContainerView: UIView
    var inputContainerView: UIView

    var backButton: BackButton
    var showIntroButton: UIButton
    var reminderListTextField: UITextField
    var reminderListLabel: UILabel
    var reminderListPicker: UIPickerView
    var reminderLists: [EKCalendar]
    var inputToolbar: UIToolbar
    var saveWithAlarmSwitch: UISwitch
    var saveWithAlarmLabel: UILabel
    
    override init() {
        self.backButtonContainerView = UIView()
        self.reminderListContainerView = UIView()
        self.showIntroButtonContainerView = UIView()
        self.saveWithAlarmContainerView = UIView()
        self.inputContainerView = UIView()

        self.backButton = BackButton()
        self.showIntroButton = UIButton()
        self.reminderListTextField = UITextField()
        self.reminderListLabel = UILabel()
        self.reminderListPicker = UIPickerView()
        self.reminderLists = []
        self.inputToolbar = UIToolbar()
        self.saveWithAlarmSwitch = UISwitch()
        self.saveWithAlarmLabel = UILabel()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        self.setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkPermission()
    }
    
    override func setupViews() {
        super.setupViews()
        
        // ContainerViews.
        self.headingLabel.text = NSLocalizedString("heading-label-settings", comment: "Heading label.")
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
       
        self.reminderListContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.reminderListContainerView)
        
        self.showIntroButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.showIntroButtonContainerView)
        
        self.saveWithAlarmContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.saveWithAlarmContainerView)
     
        // BackButton.
        self.backButton.addTarget(self, action: #selector(SettingsViewController.backButtonPressed),
                                        for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
        
        // SaveWithAlarmSwitch + Label.
        self.saveWithAlarmSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.saveWithAlarmSwitch.onTintColor = UIColor(red: 97.0/255,
                                                       green: 208.0/255,
                                                       blue: 255.0/255,
                                                       alpha: 1.0)
        self.saveWithAlarmSwitch.layer.shadowColor = UIColor.black.cgColor
        self.saveWithAlarmSwitch.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.saveWithAlarmSwitch.layer.shadowOpacity = 0.1
        self.saveWithAlarmSwitch.addTarget(self, action: #selector(self.saveWithAlarmSwitchToggled),
                                           for: .valueChanged)
        self.saveWithAlarmContainerView.addSubview(self.saveWithAlarmSwitch)

        let defaults = UserDefaults.standard
        self.saveWithAlarmSwitch.isOn = defaults.bool(forKey: "saveWithAlarm")
        
        self.saveWithAlarmLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.saveWithAlarmLabel.text = NSLocalizedString("textfield-label-add-alarm", comment: "Add alarm Label")
        self.saveWithAlarmLabel.textColor = .white
        self.saveWithAlarmLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(),
                                                         weight: .medium)
        self.saveWithAlarmLabel.lineBreakMode = .byWordWrapping
        self.saveWithAlarmLabel.numberOfLines = 0
        self.saveWithAlarmLabel.textAlignment = .left
        self.saveWithAlarmContainerView.addSubview(self.saveWithAlarmLabel)

        // InputToolBar + InputView.
        self.setupInputToolbar()

        self.inputContainerView = UIView(frame: CGRect(x: self.reminderListPicker.frame.origin.x,
                                                       y: self.reminderListPicker.frame.origin.y,
                                                       width: UIScreen.main.bounds.width,
                                                       height: LayoutHandler.getInputViewHeightForDevice(inputToolbarHeight:self.inputToolbar.frame.size.height)))
        self.inputViewBackground()
        self.inputContainerView.addSubview(self.reminderListPicker)
        
        // ReminderListPicker.
        self.reminderListPicker.delegate = self
        self.reminderListPicker.dataSource = self
        self.reminderListPicker.translatesAutoresizingMaskIntoConstraints = false
        
        // ReminderListTextField + Label.
        self.reminderListTextField.translatesAutoresizingMaskIntoConstraints = false
        self.reminderListTextField.backgroundColor = .clear
        self.reminderListTextField.layer.borderColor = UIColor.white.cgColor
        self.reminderListTextField.layer.borderWidth = 2.0
        self.reminderListTextField.layer.cornerRadius = 5.0
        self.reminderListTextField.textColor = .white
        self.reminderListTextField.borderStyle = .roundedRect
        self.reminderListTextField.delegate = self
        self.reminderListTextField.tag = 0
        self.reminderListTextField.tintColor = .clear
        self.reminderListTextField.inputView = self.inputContainerView
        self.reminderListTextField.inputAccessoryView = inputToolbar
        self.reminderListTextField.adjustsFontSizeToFitWidth = false
        self.reminderListTextField.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(),
                                                            weight: .regular)
        self.reminderListContainerView.addSubview(self.reminderListTextField)
        
        self.reminderListLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.reminderListLabel.text = NSLocalizedString("textfield-label-add-to-list", comment: "ReminderList Textfield")
        self.reminderListLabel.textColor = .white
        self.reminderListLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(),
                                                        weight: .medium)
        self.reminderListLabel.lineBreakMode = .byWordWrapping
        self.reminderListLabel.numberOfLines = 0
        self.reminderListLabel.textAlignment = .left
        self.reminderListContainerView.addSubview(self.reminderListLabel)
        
        // ShowIntroButon.
        self.showIntroButton = DefaultButton(title: NSLocalizedString("intro-button-title", comment: "Intro Button."))
        self.showIntroButton.addTarget(self, action: #selector(SettingsViewController.showIntroButtonPressed),
                                             for: .touchUpInside)
        self.showIntroButtonContainerView.addSubview(self.showIntroButton)
    }
    
    func setupInputToolbar() {
        self.inputToolbar.barStyle = .blackTranslucent
        self.inputToolbar.sizeToFit()
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("done-button-input-toolbar-settings", comment: "Done button title"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(SettingsViewController.doneButtonPressed))
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0, weight: .bold)], for: .normal)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0, weight: .bold)], for: .highlighted)
        doneButton.tintColor = UIColor.white
        
        self.inputToolbar.setItems([flexibleSpaceButton, doneButton], animated: false)
        self.inputToolbar.isUserInteractionEnabled = true
    }
    
    func setupGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "backButton": self.backButton,
            "showIntroButton": self.showIntroButton,
            "reminderListLabel": self.reminderListLabel,
            "reminderListTextField": self.reminderListTextField,
            "saveWithAlarmLabel": self.saveWithAlarmLabel,
            "saveWithAlarmSwitch": self.saveWithAlarmSwitch,
            ]
        
        let metricsDictionary: [String: Any] = [
            "backButtonSize": LayoutHandler.getBackButtonSizeForDevice(),
            "margin": LayoutHandler.getMarginForDevice(),
            "reminderListLabelWidth": self.reminderListLabel.intrinsicContentSize.width,
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.saveWithAlarmContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.saveWithAlarmContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.reminderListContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.reminderListContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.showIntroButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.showIntroButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            ])
        
        NSLayoutConstraint.activate([
            self.saveWithAlarmContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.headingContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
            self.reminderListContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.saveWithAlarmContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
            self.showIntroButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.reminderListContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
            self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.showIntroButtonContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
            ])
        
        // MARK: SaveWithAlarmContainerView Constraints.
        self.saveWithAlarmContainerView.addConstraint(NSLayoutConstraint(item: self.saveWithAlarmSwitch,
                                                                   attribute: .centerY,
                                                                   relatedBy: .equal,
                                                                   toItem: self.saveWithAlarmContainerView,
                                                                   attribute: .centerY,
                                                                   multiplier: 1.0,
                                                                   constant: 0.0))
        
        self.saveWithAlarmContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[saveWithAlarmLabel]-[saveWithAlarmSwitch]-(margin)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.saveWithAlarmContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[saveWithAlarmLabel]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.saveWithAlarmContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[saveWithAlarmSwitch]-(>=1)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        // MARK: ReminderListContainerView Constraints.
        self.reminderListContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[reminderListLabel(reminderListLabelWidth)]-[reminderListTextField]-(margin)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.reminderListContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[reminderListLabel]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.reminderListContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[reminderListTextField]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
       
        // ShowIntroButtonContainerView Constraints.
        self.showIntroButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[showIntroButton]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.showIntroButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[showIntroButton]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
       
        // MARK: BackButtonContainerView Constraints
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
        
        // InputContainerView constraints to center UIPicker.
        self.inputContainerView.addConstraint(NSLayoutConstraint(item: self.reminderListPicker,
                                                                 attribute: .centerX,
                                                                 relatedBy: .equal,
                                                                 toItem: self.inputContainerView,
                                                                 attribute: .centerX,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0))
        
        self.inputContainerView.addConstraint(NSLayoutConstraint(item: self.reminderListPicker,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: self.inputContainerView,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0))
    }
    
    // MARK: Button Actions.
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func showIntroButtonPressed() {
        let destinationController = IntroViewController()
        self.present(destinationController, animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed() {
        self.reminderListTextField.endEditing(true)
        
        ReminderListHandler.saveUserReminderList(list: self.reminderLists[self.reminderListPicker.selectedRow(inComponent: 0)])
    }
    
    // MARK: UISwitch Actions.
    @objc func saveWithAlarmSwitchToggled() {
        let defaults = UserDefaults.standard
        defaults.set(self.saveWithAlarmSwitch.isOn, forKey: "saveWithAlarm")
    }
    
    // MARK: Gesture Handeling.
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.down {
            self.dismiss(animated: true, completion:nil)
        }
    }
    // MARK: UIPicker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.reminderLists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // Create white text picker labels.
        let pickerItem = UILabel()
        pickerItem.attributedText = NSAttributedString(string: self.reminderLists[row].title,
                                                       attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20.0),NSAttributedStringKey.foregroundColor:UIColor.white])
        pickerItem.textAlignment = .center
        
        return pickerItem
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reminderListTextField.text = self.reminderLists[row].title
    }
    
    // MARK: Helper Methods.
    @objc override func checkPermission() {
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            if !granted{
                DispatchQueue.main.async {
                    self.reminderListTextField.isEnabled = false
                }
            }
            else {
                DispatchQueue.main.async {
                    let userList = ReminderListHandler.getUserReminderList(eventStore: self.eventStore)
                    self.reminderListTextField.text = userList.0.title
                    self.reminderListTextField.setNeedsLayout()
                    self.reminderLists = ReminderListHandler.getDeviceReminderLists(eventStore: self.eventStore)
                    print("siufdbaiubf")
                }
            }
        }
    }
    
    func inputViewBackground() {
        let bottomColor = UIColor(red:0.38, green:0.10, blue:0.19, alpha:1.0).cgColor
        let topColor = UIColor(red:0.38, green:0.15, blue:0.15, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.inputContainerView.frame
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.1,1.0]
        self.inputContainerView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
