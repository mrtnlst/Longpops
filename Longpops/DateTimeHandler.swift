//
//  DateTimeHandler.swift
//  Longpops
//
//  Created by martin on 22.01.18.
//

import Foundation

class DateTimeHandler {
    
    static func getCurrentTime() -> (Int, Int) {
        let time = Date()
        let calender = Calendar.current
        
        let hour = calender.component(.hour, from: time)
        let minute = calender.component(.minute, from: time)
        
        return (hour, minute)
    }
    
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
    
    // MARK: DATE
    static func getCurrentDate() -> (Int, Int, Int) {
        let date = Date()
        let calender = Calendar.current
        
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        return (day, month, year)
    }
    
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
}
