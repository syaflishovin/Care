//
//  ScheduleModel.swift
//  Care Watch App
//
//  Created by Angela Christabel on 24/03/23.
//

import Foundation

class ScheduleModel: ObservableObject {
    @Published var scheduleEndDate = UserDefaults.standard.object(forKey: "endDate") as? Date
    @Published var isScheduleActive = false
    
    func getRemainingTime() -> Int {
        let currentDate = Date()
        var remainder = 0
        
        if let endDate = scheduleEndDate {
            remainder = Int(endDate.timeIntervalSince(currentDate))
        }
        return remainder
    }
    
    func scheduleNotifications() {
        // looping utk set notifications
    }
}
