//
//  HomeNoScheduleView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct HomeNoScheduleView: View {
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 0
        ) {
            ScrollView {
                Text("It's another day at the Academy. Don't forget to rest your eyes every 20 minutes with us!")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                NavigationLink(destination: ScheduleView()) {
                    Text("Start")
                }
                .tint(.accentColor)
                .clipShape(Capsule())
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeNoScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNoScheduleView()
    }
}
