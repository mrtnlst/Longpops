//
//  AdvancedTaskViewController.swift
//  Longpops
//
//  Created by martin on 21.01.18.
//

import UIKit
import EventKit

class AdvancedTaskViewController: TaskViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var hoursTextField: UITextField
    var minutesTextField: UITextField
    var dayTextField: UITextField
    var monthTextField: UITextField
    var yearTextField: UITextField
    var reminderListTextField: UITextField
    var colonLabel: UILabel
    var dotLabel1: UILabel
    var dotLabel2: UILabel
    var inputToolbar: UIToolbar
    var dateTimer: Timer
    var countdownTimer: Timer
    
    var data = ["1", "2", "3"]
    var picker = UIPickerView()
    
    enum jumpDirection {
        case jumpForward
        case jumpBackward
    }
    
    override init() {
        self.hoursTextField = UITextField()
        self.dayTextField = UITextField()
        self.minutesTextField = UITextField()
        self.monthTextField = UITextField()
        self.yearTextField = UITextField()
        self.reminderListTextField = UITextField()
        self.colonLabel = UILabel()
        self.dotLabel1 = UILabel()
        self.dotLabel2 = UILabel()
        self.inputToolbar = UIToolbar()
        self.dateTimer = Timer()
        self.countdownTimer = Timer()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateDateTimePlaceHolder()
        self.startCountdownTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dateTimer.invalidate()
        self.countdownTimer.invalidate()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.setupInputToolbar()
        
        self.headingLabel.text = "Longpops"
        
        self.titleTextField.inputAccessoryView = inputToolbar
        self.titleTextField.autocorrectionType = .no
        
        picker.delegate = self
        picker.dataSource = self
        self.reminderListTextField.inputView = picker
        self.reminderListTextField.inputAccessoryView = inputToolbar
        
        self.hoursTextField.translatesAutoresizingMaskIntoConstraints = false
        self.hoursTextField.backgroundColor = .white
        self.hoursTextField.borderStyle = .roundedRect
        self.hoursTextField.delegate = self
        self.hoursTextField.keyboardType = .numberPad
        self.hoursTextField.keyboardAppearance = .dark
        self.hoursTextField.tag = 1
        self.hoursTextField.textAlignment = .center
        self.hoursTextField.inputAccessoryView = inputToolbar
        self.hoursTextField.addTarget(self, action: #selector(self.textFieldEditingDidChange(textField:)), for: .editingChanged)
        self.textFieldContainerView.addSubview(self.hoursTextField)
        
        self.minutesTextField.translatesAutoresizingMaskIntoConstraints = false
        self.minutesTextField.backgroundColor = .white
        self.minutesTextField.borderStyle = .roundedRect
        self.minutesTextField.delegate = self
        self.minutesTextField.keyboardType = .numberPad
        self.minutesTextField.keyboardAppearance = .dark
        self.minutesTextField.tag = 2
        self.minutesTextField.textAlignment = .center
        self.minutesTextField.inputAccessoryView = inputToolbar
        self.minutesTextField.addTarget(self, action: #selector(self.textFieldEditingDidChange(textField:)), for: .editingChanged)
        self.textFieldContainerView.addSubview(self.minutesTextField)
        
        self.dayTextField.translatesAutoresizingMaskIntoConstraints = false
        self.dayTextField.backgroundColor = .white
        self.dayTextField.borderStyle = .roundedRect
        self.dayTextField.delegate = self
        self.dayTextField.keyboardType = .numberPad
        self.dayTextField.keyboardAppearance = .dark
        self.dayTextField.tag = 3
        self.dayTextField.textAlignment = .center
        self.dayTextField.inputAccessoryView = inputToolbar
        self.dayTextField.addTarget(self, action: #selector(self.textFieldEditingDidChange(textField:)), for: .editingChanged)
        self.textFieldContainerView.addSubview(self.dayTextField)
        
        self.monthTextField.translatesAutoresizingMaskIntoConstraints = false
        self.monthTextField.backgroundColor = .white
        self.monthTextField.borderStyle = .roundedRect
        self.monthTextField.delegate = self
        self.monthTextField.keyboardType = .numberPad
        self.monthTextField.keyboardAppearance = .dark
        self.monthTextField.tag = 4
        self.monthTextField.textAlignment = .center
        self.monthTextField.inputAccessoryView = inputToolbar
        self.monthTextField.addTarget(self, action: #selector(self.textFieldEditingDidChange(textField:)), for: .editingChanged)
        self.textFieldContainerView.addSubview(self.monthTextField)
        
        self.yearTextField.translatesAutoresizingMaskIntoConstraints = false
        self.yearTextField.backgroundColor = .white
        self.yearTextField.borderStyle = .roundedRect
        self.yearTextField.delegate = self
        self.yearTextField.keyboardType = .numberPad
        self.yearTextField.keyboardAppearance = .dark
        self.yearTextField.tag = 5
        self.yearTextField.textAlignment = .center
        self.yearTextField.inputAccessoryView = inputToolbar
        self.yearTextField.addTarget(self, action: #selector(self.textFieldEditingDidChange(textField:)), for: .editingChanged)
        self.textFieldContainerView.addSubview(self.yearTextField)
        
        self.reminderListTextField.translatesAutoresizingMaskIntoConstraints = false
        self.reminderListTextField.backgroundColor = .white
        self.reminderListTextField.borderStyle = .roundedRect
//        self.reminderListTextField.placeholder = NSLocalizedString("Add to", comment: "Permission button.")
        self.reminderListTextField.delegate = self
        self.reminderListTextField.tag = 6
        self.textFieldContainerView.addSubview(self.reminderListTextField)
        
        self.colonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.colonLabel.text = ":"
        self.colonLabel.textColor = .white
        self.colonLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.textFieldContainerView.addSubview(self.colonLabel)
        
        self.dotLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.dotLabel1.text = "."
        self.dotLabel1.textColor = .white
        self.dotLabel1.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.textFieldContainerView.addSubview(self.dotLabel1)
        
        self.dotLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.dotLabel2.text = "."
        self.dotLabel2.textColor = .white
        self.dotLabel2.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.textFieldContainerView.addSubview(self.dotLabel2)
    }
    
    fileprivate func setupInputToolbar() {
        self.inputToolbar.barStyle = .blackTranslucent
        self.inputToolbar.sizeToFit()
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AdvancedTaskViewController.saveSticky))
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0, weight: .bold)], for: .normal)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0, weight: .bold)], for: .highlighted)
        doneButton.tintColor = UIColor.white
        
        let forwardButton  = UIBarButtonItem(image: UIImage(named: "ForwardButton"), style: .plain, target: self, action: #selector(self.keyboardForwardButton))
        forwardButton.tintColor = UIColor.white
        
        let backwardButton  = UIBarButtonItem(image: UIImage(named: "BackwardButton"), style: .plain, target: self, action: #selector(self.keyboardBackwardButton))
        backwardButton.tintColor = UIColor.white
        
        self.inputToolbar.setItems([fixedSpaceButton, fixedSpaceButton, flexibleSpaceButton, backwardButton, forwardButton, doneButton], animated: false)
        self.inputToolbar.isUserInteractionEnabled = true
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
            "reminderListTextField": self.reminderListTextField,
            ]
        
        let metricsDictionary: [String: Any] = [
            "smallFieldWidth": 36,
            "bigFieldWidth": 56,
            "textFieldMargin": LayoutHandler.getMarginForDevice(),
            ]
        
        // Textfields Constraints
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(textFieldMargin)-[titleTextField]-(textFieldMargin)-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: LayoutHandler.getLayoutOrder(),
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[hoursTextField]-[reminderListTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[dayTextField]-[reminderListTextField]-|",
                                                                                          options: [],
                                                                                          metrics: metricsDictionary,
                                                                                          views: viewsDictionary))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[monthTextField]-[reminderListTextField]-|",
                                                                                          options: [],
                                                                                          metrics: metricsDictionary,
                                                                                          views: viewsDictionary))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[minutesTextField]-[reminderListTextField]-|",
                                                                                          options: [],
                                                                                          metrics: metricsDictionary,
                                                                                          views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[yearTextField]-[reminderListTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[colonLabel]-[reminderListTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[dotLabel1]-[reminderListTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))

        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleTextField]-[dotLabel2]-[reminderListTextField]-|",
                                                                                  options: [],
                                                                                  metrics: metricsDictionary,
                                                                                  views: viewsDictionary))
        
        self.textFieldContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(textFieldMargin)-[reminderListTextField]-(textFieldMargin)-|",
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
        case self.reminderListTextField:
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
    
    // MARK: Keyboard Actions
    
    @objc func keyboardForwardButton() {
        
        let textField = self.getActiveTextField()
        
        // The titleTextField doesn't need formatting.
        if textField.tag == 0 || textField.tag == 6 {
            self.jumpToTextField(textField, direction: jumpDirection.jumpForward)
            return
        }
        
        // If textField is empty, jump to the next.
        if TextInputHandler.isTextFieldEmtpy(textField: textField) {
            self.jumpToTextField(textField, direction: jumpDirection.jumpForward)
            return
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
        if textField.tag == 0 || textField.tag == 6 {
            self.jumpToTextField(textField, direction: jumpDirection.jumpBackward)
            return
        }
        
        // If textField is empty, jump to the next.
        if TextInputHandler.isTextFieldEmtpy(textField: textField) {
            self.jumpToTextField(textField, direction: jumpDirection.jumpBackward)
            return
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
    
    fileprivate func jumpToTextField(_ textField: UITextField, direction: jumpDirection) {
        
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
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hitting return in titleTextField should jump first time textField.
        self.hoursTextField.becomeFirstResponder()
        self.giveHapticFeedbackOnJump()
        return true
    }
    
    // MARK: UIPicker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
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
    
    // Save Reminder
    
    override func saveSticky() {
        
        // Format last active textField if necessary.
        let activeTextField = self.getActiveTextField()
        
        if activeTextField.tag != 0 {
            if !TextInputHandler.isTextFieldEmtpy(textField: activeTextField) {
                if !TextInputHandler.isDateComponentCorrect(textField: activeTextField) {
                    activeTextField.becomeFirstResponder()
                    return
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
            let alert = UIAlertController(title: NSLocalizedString("alert-title", comment: "Alert title."), message: NSLocalizedString("alert-message", comment: "Alert message."), preferredStyle: .alert)
            
            let continueAction = UIAlertAction(title: NSLocalizedString("alert-button", comment: "Alert button."), style: .default)
            
            alert.addAction(continueAction)
            
            // Send user back to hourTextField.
            self.hoursTextField.becomeFirstResponder()
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.saveAdvancedReminder(date: isDateTimeValid.1)
        self.resetTextFields()
        self.disableButtonInteractionWhileAnimating()
        
        self.titleTextField.becomeFirstResponder()
        
        AnimationHandler.beginSuccessAnimation(createReminderButton: self.createReminderButton, forwardEnableUserInteraction: { () -> Void in
            self.enableButtonInteractionAfterAnimating()
        })
        self.giveHapticFeedbackOnSave()
    }
    
    func saveAdvancedReminder(date: Date) {
        let reminder = EKReminder(eventStore:self.eventStore)
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
        let components = Calendar.current.dateComponents(unitFlags, from: date)

        reminder.title = self.titleTextField.text!
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
    
    // MARK: Helper Methods
    
    func getActiveTextField() -> UITextField {
        
        let textFields = [self.titleTextField, self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField, self.reminderListTextField]
        
        var activeTextField = UITextField()
        
        for textField in textFields {
            if textField.isFirstResponder {
                activeTextField = textField
                break
            }
        }
        return activeTextField
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
    
    override func disableButtonInteractionWhileAnimating() {
        super.disableButtonInteractionWhileAnimating()
        self.inputToolbar.isUserInteractionEnabled = false
    }
    
    override func enableButtonInteractionAfterAnimating() {
        super.enableButtonInteractionAfterAnimating()
        self.inputToolbar.isUserInteractionEnabled = true

    }
    
    @objc func updateDateTimePlaceHolder() {
        self.hoursTextField.placeholder = DateTimeHandler.getHourString(hour: DateTimeHandler.getCurrentTime().0)
        self.minutesTextField.placeholder = DateTimeHandler.getMinuteString(minute: DateTimeHandler.getCurrentTime().1)
        self.dayTextField.placeholder = DateTimeHandler.getDayString(day: DateTimeHandler.getCurrentDate().0)
        self.monthTextField.placeholder = DateTimeHandler.getMonthString(month: DateTimeHandler.getCurrentDate().1)
        self.yearTextField.placeholder = String(format: "%d", DateTimeHandler.getCurrentDate().2)
    }
    
    func disableTextFields() {
        let textFields = [self.titleTextField, self.hoursTextField, self.minutesTextField, self.dayTextField, self.monthTextField, self.yearTextField, self.reminderListTextField]
        
        for textField in textFields {
            textField.isEnabled = false
        }
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
    
    func giveHapticFeedbackOnJump() {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
    }
    
    @objc override func checkPermission() {
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            if !granted{
                DispatchQueue.main.async {
                    self.createReminderButton.isEnabled = false
                    self.permissionButton.isHidden = false
                    self.disableTextFields()
                }
            }
            else {
                DispatchQueue.main.async {
                    self.reminderListTextField.text = "Add to: " + ReminderListHandler.getUserReminderList(eventStore: self.eventStore).title
                    self.reminderListTextField.setNeedsLayout()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
