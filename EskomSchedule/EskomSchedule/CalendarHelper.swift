//
//  CalanderHelper.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/14.
//

import Foundation
import UIKit

class CalendarHelper {
    
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let component = calendar.dateComponents([.day], from: date)
        return component.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let component = calendar.dateComponents([.year], from: date)
        return calendar.date(from: component)!
    }
    
    func weekDay(date: Date) -> Int {
        let component = calendar.dateComponents([.weekday], from: date)
        return component.weekday! - 1
    }
}
