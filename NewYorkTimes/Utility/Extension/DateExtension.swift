//
//  DateExtension.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

extension Date {
    
    public func inMilliSeconds() -> String {
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd H:m:ss.SSSS"
        return df.string(from: self)
    }
    
    func changeDateFormat(format:String)->String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from:self)
    }
    
    //String => String
    static func changeStringFormat(dateString:String,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatter.dateFormat =  Constants.Date.API_DATE_FORMAT
        if let date = dateFormatter.date(from: dateString)
        {
            dateFormatter.locale = Locale(identifier: "en_US")
            //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
            dateFormatter.dateFormat = format
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return Date.getCurrentDate()
    }
    
    //API String => Date
    static func changeAPIDateFormat(dateString:String) -> Date {
        //if string then conver date to string
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatter.dateFormat =  Constants.Date.API_DATE_FORMAT
        
        
        if  let date = (dateFormatter.date(from: dateString)) {
            return date as Date
        }
        return Date.init()
    }
    //String => Date
    static func changeDateFormat(dateString:String,format:String) -> Date {
        //if string then conver date to string
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatter.dateFormat =  format//Constants.Date.DATETIME_FORMAT
        
        
        if  let date = (dateFormatter.date(from: dateString)) {
            return date as Date
        }
        return Date.init()
    }
    
    //Date => Date (RequiredFormat)
    func convertIntoDateFormat(format:String)-> (Date) {
        //if string then convert date to string
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        
        dateFormatter.locale = Locale(identifier: "en_US")
        //dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        dateFormatter.dateFormat = format
        if  let date = (dateFormatter.date(from: dateString)) {
            return date as Date
        }
        return Date.init()
    }
    
    //Date => String (RequiredFormat)
    func convertIntoDateString(format:String)-> (String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        // dateFormatter.timeZone = TimeZone(abbreviation:"UTC")
        return dateFormatter.string(from: self)
    }
    
    static func getCurrentDate() -> (String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = Constants.Date.DATE_FORMAT
        NSLog("current date %@", dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    static func getCurrentDateTime() -> (String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = Constants.Date.DATETIME_FORMAT
        NSLog("current date %@", dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    public func convertIntoMilliSeconds() -> String {
        let time = Int64(self.timeIntervalSince1970 * 1000)
        return time.description
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
}
