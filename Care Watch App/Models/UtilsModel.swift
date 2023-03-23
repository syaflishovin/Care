//
//  UtilsModel.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import Foundation

class UtilsModel: ObservableObject {
    func getEndDate(hours: Int, minutes: Int) -> Date? {
        let now = Date()

        guard let temp = Calendar.current.date(byAdding: .hour, value: hours, to: now) else {
            print("Add hours to date failed")
            return nil
        }
        guard let result = Calendar.current.date(byAdding: .minute, value: minutes, to: temp) else {
            print("Date conversion failed")
            return nil
        }

        return result
    }
    
    func getSeconds(hours: Int, minutes: Int) -> Int {
        return (hours * 60 * 60) + (minutes * 60)
    }
    
    func convertToHours(total: Int?) -> Int {
        if let t = total {
            return Int(t / 3600)
        } else {
            return 0
        }
    }
    
    func convertToMinutes(total: Int?) -> Int {
        if let t = total {
            return Int((t % 3600) / 60)
        } else {
            return 0
        }
    }
    
    func convertToSeconds(total: Int?) -> Int {
        if let t = total {
            return Int((t % 3600) % 60)
        } else {
            return 0
        }
    }
    
    func getRemainderTime(end: Date) -> Int {
        let currentDate = Date()
        let remainder = end.timeIntervalSince(currentDate)
        return Int(remainder)
    }
}
