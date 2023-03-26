//
//  ScheduleView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI
import UserNotifications

struct ScheduleView: View {
    @ObservedObject private var utils = UtilsModel()
    @EnvironmentObject var scheduleModel: ScheduleModel
    @EnvironmentObject var router: Router
    
//    @Binding var userPath: [String]
    @State private var selectedHours: Int = 4
    @State private var selectedMinutes: Int = 0
    @State private var isButtonEnabled = false
    
    private let pickerWidth: CGFloat = 60
    private let pickerHeight: CGFloat = 80
    
    @State private var runCounter: Int = 0
    
    var body: some View {
        VStack {
            Text("How long are you working today?")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            HStack(alignment: .center, spacing: 10) {
                Picker("Hours", selection: $selectedHours) {
                    ForEach(0...23, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                    }
                }
                .frame(width: pickerWidth, height: pickerHeight)
                .onChange(of: selectedHours, perform: {
                    _ in
                    isButtonEnabled = selectedHours == 0 && selectedMinutes == 0 ? true : false
                })
                
                Text(":")
                
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(0...59, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                    }
                }
                .frame(width: pickerWidth, height: pickerHeight)
                .onChange(of: selectedMinutes, perform: {
                    _ in
                    isButtonEnabled = selectedHours == 0 && selectedMinutes == 0 ? true : false
                })
            }
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 0))
            
            NavigationLink(value: "ScheduleRunning") {
                Text("Schedule now")
            }
            .tint(.accentColor)
            .clipShape(Capsule())
            .disabled(isButtonEnabled)
            .simultaneousGesture(TapGesture().onEnded({ _ in
                let endDate = utils.getEndDate(hours: selectedHours, minutes: selectedMinutes)
                
                UserDefaults.standard.set(endDate, forKey: "endDate")
                
                scheduleModel.scheduleEndDate = endDate

                let totalTime = utils.getSeconds(hours: selectedHours, minutes: selectedMinutes)
                
                scheduleModel.scheduleNotifications(totalTime: totalTime)
            }))
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
