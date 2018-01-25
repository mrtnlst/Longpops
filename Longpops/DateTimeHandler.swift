//
//  DateTimeHandler.swift
//  Longpops
//
//  Created by martin on 22.01.18.
//

import Foundation

class DateTimeHandler {
    
    // MARK: Current Time
    static func getCurrentTime() -> (Int, Int) {
        let time = Date()
        let calender = Calendar.current
        
        let hour = calender.component(.hour, from: time)
        let minute = calender.component(.minute, from: time)
        
        return (hour, minute)
    }
    
    static func getCurrentSecond() -> Int {
        let time = Date()
        let calender = Calendar.current
        
        return calender.component(.second, from: time)
    }
    
    static func isReminderInCurrentMinute(textFieldMinute: Int) -> Bool {
        let time = Date()
        let calender = Calendar.current
        
        if  calender.component(.minute, from: time) == textFieldMinute {
            return true
        }
        
        return false
    }
    
    // MARK: Current Date
    static func getCurrentDate() -> (Int, Int, Int) {
        let date = Date()
        let calender = Calendar.current
        
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        return (day, month, year)
    }
    
    // MARK: Time Strings
    static func getHourString(hour: Int) -> String {
        var hourString: String
        
        if hour < 10 {
            hourString = String(format: "0%d", hour)
        }
        else {
            hourString = String(hour)
        }
        
        return hourString
    }
    
    static func getMinuteString(minute: Int) -> String {
        var minuteString: String
        
        if minute < 10 {
            minuteString = String(format: "0%d", minute)
        }
        else {
            minuteString = String(minute)
        }
        
        return minuteString
    }
    
    // MARK: Date Strings
    
    static func getDayString(day: Int) -> String {
        var dayString: String
        
        if day < 10 {
            dayString = String(format: "0%d", day)
        }
        else {
            dayString = String(day)
        }
        
        return dayString
    }
    
    static func getMonthString(month: Int) -> String {
        var monthString: String
        
        if month < 10 {
            monthString = String(format: "0%d", month)
        }
        else {
            monthString = String(month)
        }
        
        return monthString
    }
    
    // MARK: Validation.
    
    static func validateDate(day: Int, month: Int, year: Int, activeTextField: Int) -> (Int) {
        var dayMonth = [[31, 1], [28, 2], [31, 3], [30, 4], [31, 5], [30, 6], [31, 7], [31, 8], [30, 9], [31, 10], [30, 11], [31, 12]]
        let leapYearPair = [29, 2]
        
        if activeTextField == 5 && !isLeapYear(year: year) {
            if  month == leapYearPair[1] && day >= leapYearPair[0] {
                return 3
            }
            return -1
        }
        if isLeapYear(year: year) {
            dayMonth[1] = leapYearPair
        }
        
        for j in stride(from: 0, to: dayMonth.count, by: 1) {
            if dayMonth[j][1] == month {
                if dayMonth[j][0] < day {
                    return 3
                }
            }
        }
        return -1
    }
    
    static func isLeapYear(year: Int) -> Bool {
        if year % 4 == 0 {
            return true
        }
        return false
    }
    
    static func compareDateAndTime(hour: Int, minute: Int, day: Int, month: Int, year: Int) -> Int {
        let time = getCurrentTime()
        let date = getCurrentDate()
        
        if year < date.2 {
            return 5
        }
        
        if month < date.1 {
            return 4
        }
        
        if day < date.0 {
            return 3
        }
        
        if hour < time.1 {
            return 2
        }
        
        if minute < time.0 {
            return 1
        }
        
        return -1
    }
}
