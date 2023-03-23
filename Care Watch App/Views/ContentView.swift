//
//  ContentView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 22/03/23.
//

import SwiftUI

struct ContentView: View {
    private let endDate = UserDefaults.standard.string(forKey: "endDate")
    
    var body: some View {
        if let _ = endDate {
            HomeScheduleRunningView()
        } else {
            HomeNoScheduleView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
