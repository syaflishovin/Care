//
//  ContentView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var endDate = UserDefaults.standard.object(forKey: "endDate") as? Date
    
    @State private var scheduleExists = false
    
    var body: some View {
        NavigationView {
            VStack {
                if scheduleExists {
                    HomeScheduleRunningView()
                } else {
                    HomeNoScheduleView()
                }
            }
            .navigationTitle("Care")
        }
        .onAppear() {
            validateEndDate()
        }
    }
    
    func validateEndDate() {
        let now = Date()
        
        if let end = endDate {
            if end > now {
                scheduleExists = true
            }
        } else {
            scheduleExists = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
