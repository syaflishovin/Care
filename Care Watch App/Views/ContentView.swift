//
//  ContentView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var scheduleModel = ScheduleModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if scheduleModel.isScheduleActive {
                    HomeScheduleRunningView()
                } else {
                    HomeNoScheduleView()
                }
            }
            .navigationTitle("Care")
        }
        .environmentObject(scheduleModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ScheduleModel())
    }
}
