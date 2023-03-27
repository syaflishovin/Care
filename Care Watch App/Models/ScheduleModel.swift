//
//  ScheduleModel.swift
//  Care Watch App
//
//  Created by Angela Christabel on 24/03/23.
//

import Foundation
import UserNotifications

class ScheduleModel: ObservableObject {
    let pathWhenRunning = "ScheduleRunning"
    let pathWhenNotRunning = "SetSchedule"
    
    @Published var scheduleEndDate = UserDefaults.standard.object(forKey: "endDate") as? Date
    @Published var isScheduleActive = false
    @Published var userPath = UserDefaults.standard.array(forKey: "userPath") as? [String]
    
    func checkActive() -> Bool {
        if let endDate = scheduleEndDate {
            if endDate > Date() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func getRemainingTime() -> Int {
        let currentDate = Date()
        var remainder = 0
        
        if let endDate = scheduleEndDate {
            remainder = Int(endDate.timeIntervalSince(currentDate))
            print(endDate)
            print(remainder)
        }
        return remainder
    }
    
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleNotifications(totalTime: Int) {
        let runCounter = totalTime/60
        
        // looping for requesting notification
        for i in (1...runCounter) {
            // Rest Notification
            let content = UNMutableNotificationContent()
            content.title = "Rest Your Eyes!"
            content.sound = .default
            content.categoryIdentifier = "restCategory"
//
            let uuidString1 = UUID().uuidString
//
            let category = UNNotificationCategory(identifier: "restCategory", actions: [], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60*i), repeats: false)
            let request = UNNotificationRequest(identifier: uuidString1, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    print("scheduled successfully")
                }
                }
            
            //            Return Notification
                let content2 = UNMutableNotificationContent()
                content2.title = "Go back to work!"
                content2.sound = .default
                content2.categoryIdentifier = "returnCategory"
            
                let uuidString2 = UUID().uuidString
                
                let category2 = UNNotificationCategory(identifier: "returnCategory", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category2])
                
                let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((60*i)+20), repeats: false)
                let request2 = UNNotificationRequest(identifier: uuidString2, content: content2, trigger: trigger2)
                
            UNUserNotificationCenter.current().add(request2) { (error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    print("work scheduled successfully")
                }
            }
        }
    }
}
