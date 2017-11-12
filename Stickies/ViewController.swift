//
//  ViewController.swift
//  Stickies
//
//  Created by martin on 12.11.17.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var eventStore: EKEventStore!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonCenterX: NSLayoutConstraint!
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        self.eventStore = EKEventStore()
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            
            if !granted{
                DispatchQueue.main.async {
                    self.saveButton.isEnabled = false
                }
            }
            
        }
    }
    
    fileprivate func setupViews() {
        self.view.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 97/255, alpha: 1.0)
        
        self.view.sendSubview(toBack: self.successLabel)
        self.successLabel.alpha = 0
        
        self.saveButton.setImage(UIImage(named: "SaveButton"), for: .normal)
        self.saveButton.layer.shadowColor = UIColor.black.cgColor
        self.saveButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.saveButton.layer.shadowOpacity = 0.2
        
        self.textField.placeholder = "Remind me of .."
        self.textField.becomeFirstResponder()
        self.textField.delegate = self
    }

    fileprivate func endSuccessAnimation() {
        self.saveButtonCenterX.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.5, animations:{
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 0
        })
    }
    
    fileprivate func beginSuccessAnimation() {
        self.saveButtonCenterX.constant = -1 * (self.successLabel.frame.width / 2 + 35) //-70
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.successLabel.alpha = 1.0
        }, completion: {(true) in self.endSuccessAnimation()})
    }
    
    fileprivate func saveSticky() {
        saveNewReminder(stickyText: textField.text!)
        self.textField.text = ""
        beginSuccessAnimation()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveSticky()
    }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.saveSticky()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


