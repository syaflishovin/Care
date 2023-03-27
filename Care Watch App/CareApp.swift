//
//  CareApp.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

@main
struct Care_Watch_AppApp: App {
    @StateObject var scheduleModel = ScheduleModel()
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(scheduleModel)
        }
//#if os(watchOS)
        WKNotificationScene(controller: RestNotificationController.self, category: "restCategory")
        WKNotificationScene(controller: ReturnNotificationController.self, category: "returnCategory")
//        #endif
    }
}
