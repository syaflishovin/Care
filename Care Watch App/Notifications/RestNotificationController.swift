//
//  RestNotificationController.swift
//  Care Watch App
//
//  Created by Syafli Shovin on 24/03/23.
//

import WatchKit
import SwiftUI
import UserNotifications

class RestNotificationController: WKUserNotificationHostingController<RestNotificationView> {

    var title: String?
    var message: String?
    

    override var body: RestNotificationView {
        return RestNotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.

      
        
        
//
//        let notificationData =
//                notification.request.content.userInfo as? [String: Any]
//
//            let aps = notificationData?["aps"] as? [String: Any]
//            let alert = aps?["alert"] as? [String: Any]
//
//            title = alert?["title"] as? String
//            message = alert?["body"] as? String

            
    }
}
