//
//  HomeScheduleRunningView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct HomeScheduleRunningView: View {
    @ObservedObject private var viewModel = LottieViewModel()
    @ObservedObject private var utils = UtilsModel()
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    @State private var remainingTime: Int = 0
    
    @State private var isTimerActive = true
    
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
            
            Text("Next rest in:")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            HStack {
                Text(String(format: "%02d", hours))
                    .onReceive(timer) { _ in
                        if remainingTime > 0 && isTimerActive {
                            remainingTime -= 1
                            updateTimer(remaining: remainingTime)
                        } else {
                            isTimerActive = false
                        }
                    }
                Text(":")
                Text(String(format: "%02d", minutes))
                Text(":")
                Text(String(format: "%02d", seconds))
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if let end = UserDefaults.standard.object(forKey: "endDate") as? Date {
                remainingTime = utils.getRemainderTime(end: end)
                updateTimer(remaining: remainingTime)
            }
        })
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
