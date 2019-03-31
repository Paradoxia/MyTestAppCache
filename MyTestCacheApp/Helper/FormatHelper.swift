//
//  FormatHelper.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

class FormatHelper {
    
    static func dateToText(_ date : Date) -> String {
        let dateAsInterval = date.toMillis()!
        return "\(dateAsInterval)"
    }
    
    static func textToDate(_ text : String) -> Date {
        let textAsMillis = Int64.init(text)
        return Date(millis: textAsMillis!)
    }
    
    static func addSecondsToDate(_ date : Date,_ seconds : Int64) -> Date {
        let dateWithAddedMs = date.toMillis() + (seconds * 1000)
        return Date(millis: dateWithAddedMs)
    }
    
    static func getDateDiffInSeconds(_ dateA : Date, _ dateB : Date) -> Int {
        let diffInSeconds = dateB.timeIntervalSince(dateA).rounded()
        return Int(diffInSeconds)
    }
    
    // Utility method that construct a Date instance based on input parameters
    static func createCustomDate(_ year : Int,_ month : Int,_ day : Int,_ hour : Int,_ min : Int,_ sec : Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = min
        dateComponents.second = sec
        let calendar = Calendar.current // user calendar
        return calendar.date(from: dateComponents)!
        
    }
    
    static func dateToReadableString(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}
