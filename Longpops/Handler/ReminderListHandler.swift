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
    
    static func getUserReminderList(eventStore: EKEventStore) -> (EKCalendar, Int) {
        let defaults = UserDefaults.standard
        
        let defaultList = defaults.string(forKey: "defaultList")
        
        if defaultList == nil {
            return (eventStore.defaultCalendarForNewReminders()!, 0)
        }
        
        return compareDeviceAndUserLists(userList: defaultList!, eventStore: eventStore)
    }
    
    static func compareDeviceAndUserLists(userList: String, eventStore: EKEventStore) -> (EKCalendar, Int) {
        
        let reminderLists = getDeviceReminderLists(eventStore: eventStore)
        
        for (index, list) in reminderLists.enumerated() {
            if list.title == userList {
                return (list, index)
            }
        }
        return (eventStore.defaultCalendarForNewReminders()!, 0)
    }
    
    static func saveUserReminderList(list: EKCalendar) {
        let defaults = UserDefaults.standard
        defaults.set(list.title, forKey: "defaultList")
    }
}
