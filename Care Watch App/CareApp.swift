//
//  CareApp.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

@main
struct Care_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//#if os(watchOS)
        WKNotificationScene(controller: RestNotificationController.self, category: "restCategory")
        WKNotificationScene(controller: ReturnNotificationController.self, category: "returnCategory")
//        #endif
    }
}
