//
//  HomeScheduleRunningView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct HomeScheduleRunningView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var scheduleModel: ScheduleModel
    
    @ObservedObject private var viewModel = LottieViewModel()
    @ObservedObject private var utils = UtilsModel()
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @State private var remainingTime: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let animWidth = 100.0
    private let animHeight = 100.0
    
    var body: some View {
        ScrollView {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(width: animWidth, height: animHeight)
                .onAppear {
                   self.viewModel.loadAnimationFromFile(filename: "Animation")
               }
            
            Text("Current schedule running for:")
                .font(.system(size: 14))
                .frame(width: 150)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            HStack {
                Text(String(format: "%02d", hours))
                    .font(.system(size:20))
                Text(":")
                    .font(.system(size:20))
                Text(String(format: "%02d", minutes))
                    .font(.system(size:20))
                Text(":")
                    .font(.system(size:20))
                Text(String(format: "%02d", seconds))
                    .font(.system(size:20))
            }
            .onReceive(timer) { _ in
                if remainingTime > 0 && scheduleModel.isScheduleActive {
                    remainingTime -= 1
                    updateTimer(remaining: remainingTime)
                } else {
                    scheduleModel.isScheduleActive = false
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))
            
            Button("Stop schedule") {
                let endDate: Date? = nil
                UserDefaults.standard.set(endDate, forKey: "endDate")
                scheduleModel.scheduleEndDate = endDate
                scheduleModel.isScheduleActive = false
            }
            .tint(.red)
            .clipShape(Capsule())
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            getRemainingTime()
        })
    }
    
    func getRemainingTime() {
        remainingTime = scheduleModel.getRemainingTime()
    }
    
    func updateTimer(remaining: Int) {
        hours = utils.convertToHours(total: remaining)
        minutes = utils.convertToMinutes(total: remaining)
        seconds = utils.convertToSeconds(total: remaining)
    }
}

struct HomeScheduleRunningView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScheduleRunningView().environmentObject(ScheduleModel())
    }
}
