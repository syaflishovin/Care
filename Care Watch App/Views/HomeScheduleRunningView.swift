//
//  HomeScheduleRunningView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct HomeScheduleRunningView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var scheduleModel: ScheduleModel
    @EnvironmentObject var router: Router
    
    @ObservedObject private var viewModel = LottieViewModel()
    @ObservedObject private var utils = UtilsModel()
    
//    @Binding var userPath: [String]
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @State private var remainingTime: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let animWidth = 90.0
    private let animHeight = 90.0
    @State private var defaultTab = 1
    
    var body: some View {
        TabView(selection: $defaultTab) {
            VStack {
                Button {
                    let endDate: Date? = nil
                    
                    UserDefaults.standard.set(endDate, forKey: "endDate")
                    
                    scheduleModel.scheduleEndDate = endDate
                    
                    timer.upstream.connect().cancel()
                    router.reset()
                } label: {
                    Image(systemName: "xmark")
                }
                .frame(width: 60)
                .tint(.red)
                .clipShape(Capsule())
                
                Text("Stop")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
            }
            .navigationTitle("More")
            .tag(0)
            
            ScrollView {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .frame(width: animWidth, height: animHeight)
                    .onAppear {
                        self.viewModel.loadAnimationFromFile(filename: "Phase 4")
                    }
                
                Text("Current schedule running for:")
                    .font(.system(size: 13))
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
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
                    if remainingTime > 0 && scheduleModel.checkActive() {
                        remainingTime -= 1
                        updateTimer(remaining: remainingTime)
                    } else {
                        timer.upstream.connect().cancel()
                        router.reset()
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear() {
                getRemainingTime()
            }
            .onChange(of: scenePhase, perform: { newPhase in
                print("On change")
                if newPhase == .active {
                    getRemainingTime()
                }
            })
            .tag(1)
        }
        .navigationBarBackButtonHidden(true)
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
        HomeScheduleRunningView()
    }
}
