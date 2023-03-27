//
//  ContentView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var scheduleModel: ScheduleModel
    @EnvironmentObject var router: Router
//    @State var userPath: [String] = []
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                Text("It's another day at the Academy. Don't forget to rest your eyes every 20 minutes with us!")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                NavigationLink(value: "SetSchedule") {
                    Text("Start")
                }
                .tint(.accentColor)
                .clipShape(Capsule())
            }
            .navigationTitle("Care")
            .navigationDestination(for: String.self) { page in
                if page == "SetSchedule" {
                    ScheduleView()
                } else if page == "ScheduleRunning" {
                    HomeScheduleRunningView()
                } else if page == "Complete" {
                    CompletionView()
                } else {
                    VStack {
                        Button("Back to home") {
                            router.reset()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear() {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert,.sound,.badge])
            { (success, error) in
                if success{
                    print("All set")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            if scheduleModel.checkActive() {
                router.path.append("ScheduleRunning")
            }
        }
        .environmentObject(scheduleModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ScheduleModel())
            .environmentObject(Router())
    }
}
