//
//  AdvancedTaskViewController.swift
//  Longpops
//
//  Created by martin on 21.01.18.
//

import UIKit
import EventKit

class AdvancedTaskViewController: TemplateViewController {

    var navigationItemContainerView: UIView
    var textFieldContainerView: UIView
    var permissionButtonContainerView: UIView
    var timeContainerView: UIView
    var dateContainerView: UIView
    
    var titleTextField: UITextField
    var permissionButton: UIButton
    var infoButton: UIButton
    var settingsButton: UIButton
    var hoursTextField: UITextField
    var minutesTextField: UITextField
    var dayTextField: UITextField
    var monthTextField: UITextField
    var yearTextField: UITextField
    var colonLabel: UILabel
    var dotLabel1: UILabel
    var dotLabel2: UILabel
    var inputToolbar: UIToolbar
    var dateTimer: Timer
    var countdownTimer: Timer
    var timeButton: UIButton
    var calendarButton: UIButton
    var savedImage: UIImageView

    enum jumpDirection {
        case jumpForward
        case jumpBackward
    }
    
    override init() {
        self.navigationItemContainerView = UIView()
        self.textFieldContainerView = UIView()
        self.permissionButtonContainerView = UIView()
        self.timeContainerView = UIView()
        self.dateContainerView = UIView()
        
        self.hoursTextField = UITextField()
        self.dayTextField = UITextField()
        self.minutesTextField = UITextField()
        self.monthTextField = UITextField()
        self.yearTextField = UITextField()
        self.colonLabel = UILabel()
        self.dotLabel1 = UILabel()
        self.dotLabel2 = UILabel()
        self.inputToolbar = UIToolbar()
        self.dateTimer = Timer()
        self.countdownTimer = Timer()
        self.timeButton = UIButton()
        self.calendarButton = UIButton()
        self.savedImage = UIImageView()
        self.titleTextField = UITextField()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground),
                                               name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground),
                                               name: .UIApplicationDidEnterBackground, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleTextField.becomeFirstResponder()
        self.updateDateTimePlaceHolder()
        self.startCountdownTimer()
        
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: "saveWithAlarm") {
            self.disableDateTimeTextFields()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkForIntro()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dateTimer.invalidate()
        self.countdownTimer.invalidate()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.inputToolbar = InputToolbar()
        
        self.navigationItemContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.navigationItemContainerView)
        
        self.textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.textFieldContainerView)
        
        self.permissionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.permissionButtonContainerView)
        
        self.permissionButton = DefaultButton.init(title: NSLocalizedString("permission-button-title", comment: "Permission button."))
        self.permissionButton.addTarget(self, action: #selector(AdvancedTaskViewController.permissionButtonPressed), for: .touchUpInside)
        self.permissionButton.isHidden = true
        self.permissionButtonContainerView.addSubview(self.permissionButton)
        
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.setImage(UIImage(named: "InfoButton"), for: .normal)
        self.infoButton.addTarget(self, action: #selector(AdvancedTaskViewController.infoButtonPressed), for: .touchUpInside)
        self.infoButton.tintColor = .white
        self.navigationItemContainerView.addSubview(self.infoButton)
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.setImage(UIImage(named: "SettingsButton"), for: .normal)
        self.settingsButton.addTarget(self, action: #selector(AdvancedTaskViewController.settingsButtonPressed), for: .touchUpInside)
        self.settingsButton.tintColor = .white
        self.navigationItemContainerView.addSubview(self.settingsButton)
        
        self.titleTextField = TitleTextField(tag: 0)
        self.titleTextField.delegate = self
        self.titleTextField.inputAccessoryView = inputToolbar
        self.textFieldContainerView.addSubview(self.titleTextField)
        
        self.timeContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.textFieldContainerView.addSubview(self.timeContainerView)
        
        self.timeButton.translatesAutoresizingMaskIntoConstraints = false
        self.timeButton.setImage(UIImage(named: "Time"), for: .normal)
        self.timeButton.addTarget(self, action: #selector(AdvancedTaskViewController.timeButtonPressed), for: .touchUpInside)
        self.timeButton.tintColor = .white
        self.timeContainerView.addSubview(self.timeButton)
        
        self.dateContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.textFieldContainerView.addSubview(self.dateContainerView)
        
        self.calendarButton.translatesAutoresizingMaskIntoConstraints = false
        self.calendarButton.setImage(UIImage(named: "Calendar"), for: .normal)
        self.calendarButton.addTarget(self, action: #selector(AdvancedTaskViewController.calendarButtonPressed), for: .touchUpInside)
        self.calendarButton.tintColor = .white
        self.dateContainerView.addSubview(self.calendarButton)
        
        self.hoursTextField = DateTimeTextField(tag: 1)
        self.hoursTextField.delegate = self
        self.hoursTextField.inputAccessoryView = inputToolbar
        self.timeContainerView.addSubview(self.hoursTextField)
        
        self.minutesTextField = DateTimeTextField(tag: 2)
        self.minutesTextField.delegate = self
        self.minutesTextField.inputAccessoryView = inputToolbar
        self.timeContainerView.addSubview(self.minutesTextField)
        
        self.dayTextField = DateTimeTextField(tag: 3)
        self.dayTextField.delegate = self
        self.dayTextField.inputAccessoryView = inputToolbar
        self.dateContainerView.addSubview(self.dayTextField)
        
        self.monthTextField = DateTimeTextField(tag: 4)
        self.monthTextField.delegate = self
        self.monthTextField.inputAccessoryView = inputToolbar
        self.dateContainerView.addSubview(self.monthTextField)
        
        self.yearTextField = DateTimeTextField(tag: 5)
        self.yearTextField.delegate = self
        self.yearTextField.inputAccessoryView = inputToolbar
        self.dateContainerView.addSubview(self.yearTextField)
        
        self.colonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.colonLabel.text = ":"
        self.colonLabel.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.colonLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getDateTimeTextFontSizeForDevice(), weight: .bold)
        self.timeContainerView.addSubview(self.colonLabel)
        
        self.dotLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.dotLabel1.text = "."
        self.dotLabel1.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.dotLabel1.font = UIFont.systemFont(ofSize: LayoutHandler.getDateTimeTextFontSizeForDevice(), weight: .bold)
        self.dateContainerView.addSubview(self.dotLabel1)
        
        self.dotLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.dotLabel2.text = "."
        self.dotLabel2.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.dotLabel2.font = UIFont.systemFont(ofSize: LayoutHandler.getDateTimeTextFontSizeForDevice(), weight: .bold)
        self.dateContainerView.addSubview(self.dotLabel2)
        
        self.savedImage.image = UIImage(named: "SuccessButton")
        self.savedImage.translatesAutoresizingMaskIntoConstraints = false
        self.savedImage.alpha = 0
        self.dateContainerView.addSubview(self.savedImage)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "titleTextField": self.titleTextField,
            "dayTextField": self.dayTextField,
            "minutesTextField": self.minutesTextField,
            "monthTextField": self.monthTextField,
            "hoursTextField": self.hoursTextField,
            "yearTextField": self.yearTextField,
            "colonLabel": self.colonLabel,
            "dotLabel1": self.dotLabel1,
            "dotLabel2": self.dotLabel2,
            "dateContainerView": self.dateContainerView,
            "timeContainerView": self.timeContainerView,
            "timeButton": self.timeButton,
            "calendarButton": self.calendarButton,
            "savedImage": self.savedImage,
            "navigationItemContainerView": self.navigationItemContainerView,
            "textFieldContainerView": self.textFieldContainerView,
            "permissionButtonContainerView": self.permissionButtonContainerView,
            "permissionButton": self.permissionButton,
            "infoButton": self.infoButton,
            "settingsButton": self.settingsButton,
            ]
        
        let metricsDictionary: [String: Any] = [
            "smallFieldWidth": LayoutHandler.getSmallLabelWidth(),
            "bigFieldWidth": LayoutHandler.getBigLabelWidth(),
            "textFieldMargin": LayoutHandler.getMarginForDevice(),
            "imageSize": LayoutHandler.getSavedImageSize(),
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.navigationItemContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.navigationItemContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.textFieldContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.textFieldContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.permissionButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.permissionButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.navigationItemContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 0),
            
            self.textFieldContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.navigationItemContainerView.bottomAnchor, multiplier: 0),
            
            self.permissionButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.textFieldContainerView.bottomAnchor, multiplier: 0),
            ])
        
        // Navigation item Constraints
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[settingsButton(imageSize)]-(>=1)-[infoButton(imageSize)]-|",
                                                                                       options: .alignAllLastBaseline,
                                                                                       metrics: metricsDictionary,
                                                                                       views: viewsDictionary))
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[settingsButton(imageSize)]-|",
                                                                                       options: [],
                                                                                       metrics: metricsDictionary,
                                                                                       views: viewsDictionary))
        
        self.navigationItemContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[infoButton(imageSize)]-|",
                                                                                       options: [],
                                                                                       metrics: metricsDictionary,
                                                                                       views: viewsDictionary))
        
        // Permission Button Constraints
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
        
        self.permissionButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[permissionButton]-|",
                                                                                         options: [],
                                                                                         metrics: metricsDictionary,
                                                                                         views: viewsDictionary))
        
        // TextFieldContainer 
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(textFieldMargin)-[titleTextField]-(textFieldMargin)-|",
                                                                                      options: [],
                                                                                      metrics: metricsDictionary,
                                                                                      views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[timeContainerView]-[dateContainerView]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[timeContainerView]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
       
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dateContainerView]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
    
        // TimeContainerView
        
        self.timeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[hoursTextField(smallFieldWidth)][colonLabel][minutesTextField(smallFieldWidth)]-(textFieldMargin)-[timeButton(imageSize)]|",
                                                                          options: [],
                                                                          metrics: metricsDictionary,
                                                                          views: viewsDictionary))
    
        self.timeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[timeButton(imageSize)]-|",
                                                                             options: [],
                                                                             metrics: metricsDictionary,
                                                                             views: viewsDictionary))
        
        self.timeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[minutesTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.timeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hoursTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.timeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[colonLabel]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))

        // DateContainerView
        
        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: LayoutHandler.getLayoutOrder(),
                                                                             options: [],
                                                                             metrics: metricsDictionary,
                                                                             views: viewsDictionary))
    
        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[savedImage(imageSize)]-|",
                                                                             options: [],
                                                                             metrics: metricsDictionary,
                                                                             views: viewsDictionary))

        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[dayTextField]-|",
                                                                                          options: [],
                                                                                          metrics: metricsDictionary,
                                                                                          views: viewsDictionary))

        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[monthTextField]-|",
                                                                                          options: [],
                                                                                          metrics: metricsDictionary,
                                                                                          views: viewsDictionary))

        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[calendarButton(imageSize)]-|",
                                                                             options: [],
                                                                             metrics: metricsDictionary,
                                                                             views: viewsDictionary))

        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[yearTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))



        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[dotLabel1]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))

        self.dateContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[dotLabel2]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        }
    
    // MARK: TextField Actions
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Allow backspace.
        if string.count == 0 {
            return true
        }
        
        // Check input characters.
        switch textField {
        case self.titleTextField:
            return true
        case self.yearTextField:
            if TextInputHandler.isStringAnInt(string: string) {
                return true
            }
        default:
            if TextInputHandler.isStringAnInt(string: string) {
                return true
            }
        }
        return false
    }
    
    @objc func textFieldEditingDidChange(textField: UITextField) {
        
        // Check whether the date component is valid, otherwise select text.
        if TextInputHandler.isDateComponentCorrect(textField: textField) {
            
            // Skip to next textField, if maximum digits are reached.
            if TextInputHandler.shouldSkipToNextTextField(textField: textField) {
                
                if textField.tag == 4 || textField.tag == 5 {
                    let values = self.getTextFieldValues()
                    
                    if DateTimeHandler.validateDate(day: values[2], month: values[3], year: values[4], activeTextField: textField.tag) > 0  {
                        self.dayTextField.becomeFirstResponder()
                        self.giveHapticFeedbackOnJump()
                        return
                    }
                }
                
                let nextField = TextInputHandler.jumpToNextTextField(tag: textField.tag)
                
                if nextField == 0 {
                    self.titleTextField.becomeFirstResponder()
                }
                else {
                    self.view.viewWithTag(nextField)?.becomeFirstResponder()
                }
                self.giveHapticFeedbackOnJump()
            }
        }
        else {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
            self.giveHapticFeedbackOnJump()
        }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let textContent = textField.text {
            if TextInputHandler.getNumberOfDigits(string: textContent) > 0 {
                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
            }
        }
    }
    
    func disableTextFields() {
        let textFields = [self.titleTextField, self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        for textField in textFields {
            textField.isEnabled = false
        }
    }
    
    func disableDateTimeTextFields() {
        let textFields = [self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        for textField in textFields {
            textField.isEnabled = false
        }
    }
    
    func getActiveTextField() -> UITextField {
        
        let textFields = [self.titleTextField, self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        var activeTextField = UITextField()
        
        for textField in textFields {
            if textField.isFirstResponder {
                activeTextField = textField
                break
            }
        }
        return activeTextField
    }
    
    @objc func updateEditedTextFieldsWithCurrentDateTime() {
        let textFields = [self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        for textField in textFields {
            if textField.text != "" {
                textField.text = ""
            }
        }
        
        self.updateDateTimePlaceHolder()
    }
    
    func getTextFieldValues() -> [Int]{
        var values = [Int]()
        let textFields = [self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        for textField in textFields {
            if let value = Int(textField.text!) {
                values.append(value)
            }
            else {
                values.append(Int(textField.placeholder!)!)
            }
        }
        return values
    }
    
    func resetTextFields() {
        let textFields = [self.titleTextField, self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField]
        
        for textField in textFields {
            textField.text = ""
        }
    }
    
    // MARK: Keyboard Actions
    
    @objc func keyboardForwardButton() {
        
        let textField = self.getActiveTextField()
        
        // The titleTextField doesn't need formatting.
        if textField.tag == 0 {
            self.jumpToTextField(textField, direction: jumpDirection.jumpForward)
            return
        }
        
        // If textField is empty, jump to the next.
        if TextInputHandler.isTextFieldEmtpy(textField: textField) {
            self.jumpToTextField(textField, direction: jumpDirection.jumpForward)
            return
        }
        
        // Check whether yeat format is valid.
        if textField.tag == 5 {
            if !TextInputHandler.isYearComponentCorrect(yearTextField: textField) {
                 textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                return
            }
        }

        // Format textFields if necessary.
        if !TextInputHandler.isDateComponentCorrect(textField: textField) {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
            return
        }
        else {
            if textField.tag == 4 || textField.tag == 5 {
                let values = self.getTextFieldValues()
                
                if DateTimeHandler.validateDate(day: values[2], month: values[3], year: values[4], activeTextField: textField.tag) > 0  {
                    self.giveHapticFeedbackOnJump()
                    self.dayTextField.becomeFirstResponder()
                    return
                }
            }
            self.getActiveTextField().text = TextInputHandler.formatTextField(textField)
        }
        self.jumpToTextField(textField, direction: jumpDirection.jumpForward)
    }
    
    @objc func keyboardBackwardButton() {
        
        let textField = self.getActiveTextField()
        
        // The titleTextField doesn't need formatting.
        if textField.tag == 0 {
            self.jumpToTextField(textField, direction: jumpDirection.jumpBackward)
            return
        }
        
        // If textField is empty, jump to the next.
        if TextInputHandler.isTextFieldEmtpy(textField: textField) {
            self.jumpToTextField(textField, direction: jumpDirection.jumpBackward)
            return
        }
        
        // Check whether yeat format is valid.
        if textField.tag == 5 {
            if !TextInputHandler.isYearComponentCorrect(yearTextField: textField) {
                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                return
            }
        }
        
        // Format textFields if necessary.
        if !TextInputHandler.isDateComponentCorrect(textField: textField) {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
            return
        }
        else {
            if textField.tag == 4 || textField.tag == 5 {
                let values = self.getTextFieldValues()
                
                if DateTimeHandler.validateDate(day: values[2], month: values[3], year: values[4], activeTextField: textField.tag) > 0 {
                    self.giveHapticFeedbackOnJump()
                    self.dayTextField.becomeFirstResponder()
                    return
                }
            }
            self.getActiveTextField().text = TextInputHandler.formatTextField(textField)
        }
        self.jumpToTextField(textField, direction: jumpDirection.jumpBackward)
    }
    
    func jumpToTextField(_ textField: UITextField, direction: jumpDirection) {
        
        // Determine the next TextField to become active.
        var nextField: Int
        
        if direction == jumpDirection.jumpForward {
            nextField = TextInputHandler.jumpToNextTextField(tag: textField.tag)
        }
        else {
            nextField = TextInputHandler.jumpToPreviousTextField(tag: textField.tag)
        }
        
        if nextField == 0 {
            self.titleTextField.becomeFirstResponder()
        }
        else {
            self.view.viewWithTag(nextField)?.becomeFirstResponder()
        }
        
        self.giveHapticFeedbackOnJump()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hitting return in titleTextField should jump first time textField.
        self.hoursTextField.becomeFirstResponder()
        self.giveHapticFeedbackOnJump()
        return true
    }
    
    // MARK: UIButton Actions
    
    @objc func timeButtonPressed() {
        self.hoursTextField.becomeFirstResponder()
    }
    
    @objc func calendarButtonPressed() {
        self.dayTextField.becomeFirstResponder()
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
    
    // MARK: Timers
    
    func startCountdownTimer() {
        
        // Caclulate seconds to full minute.
        let remainingSeconds = 60 - DateTimeHandler.getCurrentSecond()
        self.countdownTimer = Timer.scheduledTimer(timeInterval: TimeInterval(remainingSeconds), target: self, selector: #selector(self.startDateTimer), userInfo: nil, repeats: false)
    }
    
    @objc func startDateTimer() {
        
        // Update labels every minute.
        self.dateTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.updateDateTimePlaceHolder), userInfo: nil, repeats: true)
        self.dateTimer.fire()
    }
    
    @objc func updateDateTimePlaceHolder() {
        
        self.hoursTextField.attributedPlaceholder = NSAttributedString(string: DateTimeHandler.getHourString(hour: DateTimeHandler.getCurrentTime().0),
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(
                                                                        red: 255/255,
                                                                        green: 255/255,
                                                                        blue: 255/255,
                                                                        alpha: 0.5)])
        self.minutesTextField.attributedPlaceholder = NSAttributedString(string: DateTimeHandler.getMinuteString(minute: DateTimeHandler.getCurrentTime().1),
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(
                                                                            red: 255/255,
                                                                            green: 255/255,
                                                                            blue: 255/255,
                                                                            alpha: 0.5)])
        
        self.dayTextField.attributedPlaceholder = NSAttributedString(string: DateTimeHandler.getDayString(day: DateTimeHandler.getCurrentDate().0),
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(
                                                                        red: 255/255,
                                                                        green: 255/255,
                                                                        blue: 255/255,
                                                                        alpha: 0.5)])
        
        self.monthTextField.attributedPlaceholder = NSAttributedString(string: DateTimeHandler.getMonthString(month: DateTimeHandler.getCurrentDate().1),
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(
                                                                        red: 255/255,
                                                                        green: 255/255,
                                                                        blue: 255/255,
                                                                        alpha: 0.5)])
        
        self.yearTextField.attributedPlaceholder = NSAttributedString(string: String(format: "%d", DateTimeHandler.getCurrentDate().2),
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(
                                                                        red: 255/255,
                                                                        green: 255/255,
                                                                        blue: 255/255,
                                                                        alpha: 0.5)])
        
    }
    
    @objc func willEnterForeground() {
        self.updateDateTimePlaceHolder()
        self.startCountdownTimer()
        print("Timers activated.")
    }
    
    @objc func didEnterBackground() {
        self.dateTimer.invalidate()
        self.countdownTimer.invalidate()
        print("Timers invalidated.")
    }
    
    // Save Reminder
    
    @objc func saveButtonPressed() {
        
        // Format last active textField if necessary.
        let activeTextField = self.getActiveTextField()
        
        if 1 ... 5 ~= activeTextField.tag  {
            if !TextInputHandler.isTextFieldEmtpy(textField: activeTextField) {
                if !TextInputHandler.isDateComponentCorrect(textField: activeTextField) {
                    activeTextField.becomeFirstResponder()
                    return
                }
                if activeTextField.tag == 5 {
                    if !TextInputHandler.isYearComponentCorrect(yearTextField: activeTextField) {
                        // Create an alert.
                        let alert = AlertHandler.createErrorAlert()
                        
                        // Send user back to hourTextField.
                        self.yearTextField.becomeFirstResponder()
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                activeTextField.text = TextInputHandler.formatTextField(activeTextField)
            }
        }
        
        // Get textField values from .text or .placeholder.
        let textFieldValues = self.getTextFieldValues()
        
        // Validate date.
        if DateTimeHandler.validateDate(day: textFieldValues[2], month: textFieldValues[3], year: textFieldValues[4], activeTextField: activeTextField.tag) > 0 {
            self.giveHapticFeedbackOnJump()
            self.dayTextField.becomeFirstResponder()
            return
        }
        
        // Compare with current date and time.
        let isDateTimeValid = DateTimeHandler.compareDateAndTime(hour: textFieldValues[0], minute: textFieldValues[1], day: textFieldValues[2], month: textFieldValues[3], year: textFieldValues[4])
        
        if  !isDateTimeValid.0 {
            
            // Create an alert.
            let alert = AlertHandler.createErrorAlert()
            
            // Send user back to hourTextField.
            self.hoursTextField.becomeFirstResponder()
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Create reminder item and save reminder list.
        self.saveAdvancedReminder(date: isDateTimeValid.1)
        
        // Reset textFields.
        self.resetTextFields()
        self.titleTextField.becomeFirstResponder()
        
        // Save animation.
        self.disableButtonInteractionWhileAnimating()
        AnimationHandler.beginSuccessAnimation(savedImage: self.savedImage, forwardEnableUserInteraction: { () -> Void in
            self.enableButtonInteractionAfterAnimating()
        })
        self.giveHapticFeedbackOnSave()
    }
    
    func saveAdvancedReminder(date: Date) {
        let reminder = EKReminder(eventStore:self.eventStore)
        reminder.title = self.titleTextField.text!

        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "saveWithAlarm") {
        
            let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
            let components = Calendar.current.dateComponents(unitFlags, from: date)
            
            reminder.dueDateComponents = components
            reminder.addAlarm(EKAlarm.init(absoluteDate: date))
        }
        
        reminder.calendar = ReminderListHandler.getUserReminderList(eventStore: self.eventStore).0
        
        do {
            try self.eventStore.save(reminder, commit: true)
            print("Saved")
        }
        catch {
            print("Error creating and saving new reminder : \(error)")
        }
    }
    
    // MARK: Show Intro
    
    func checkForIntro() {
        let defaults = UserDefaults.standard
        let showIntro = defaults.bool(forKey: "showIntro2.1")
        
        if !showIntro {
            let destinationController = IntroViewController()
            self.present(destinationController, animated: true, completion: nil)
        }
        else {
            self.checkPermission()
        }
    }
    
    // MARK: Helper Methods
    
    func disableButtonInteractionWhileAnimating() {
        self.inputToolbar.isUserInteractionEnabled = false
    }
    
    func enableButtonInteractionAfterAnimating() {
        self.inputToolbar.isUserInteractionEnabled = true
    }
    
    func giveHapticFeedbackOnJump() {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
    }
    
    func giveHapticFeedbackOnSave() {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }
    }
    
    @objc override func checkPermission() {
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            if !granted{
                DispatchQueue.main.async {
                    self.permissionButton.isHidden = false
                    self.disableTextFields()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
