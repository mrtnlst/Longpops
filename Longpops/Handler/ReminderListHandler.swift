//
//  ReminderListHandler.swift
//  Longpops
//
//  Created by martin on 19.02.18.
//

import Foundation
import EventKit

class ReminderListHandler {
    
    static func getDeviceReminderLists(eventStore: EKEventStore) -> [EKCalendar] {
        return eventStore.calendars(for: .reminder)
    }
    
    static func getUserReminderList(eventStore: EKEventStore) -> EKCalendar{
        let defaults = UserDefaults.standard
        
        let defaultList = defaults.object(forKey: "defaultList")
        
        if defaultList == nil {
            return eventStore.defaultCalendarForNewReminders()!
        }
        
        return defaultList as! EKCalendar
    }
    
    static func saveUserReminderList(list: EKCalendar) {
        let defaults = UserDefaults.standard
        defaults.set(list, forKey: "defaultList")
    }
}
