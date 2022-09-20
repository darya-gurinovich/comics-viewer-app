//
//  File.swift
//  
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import Foundation

extension Date {
    static func from(year: String, month: String, day: String) -> Date? {
        guard let year = Int(year),
              let month = Int(month),
              let day = Int(day) else {
            return nil
        }
        
        return from(year: year, month: month, day: day)
    }
    
    static func from(year: Int, month: Int, day: Int) -> Date? {
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian) else { return nil }

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        guard let date = gregorianCalendar.date(from: dateComponents) else { return nil }
        
        return date
    }
}
