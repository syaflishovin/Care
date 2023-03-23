//
//  ScheduleModel.swift
//  Care Watch App
//
//  Created by Angela Christabel on 24/03/23.
//

import Foundation

class ScheduleModel: ObservableObject {
    @Published private var scheduleEndDate = UserDefaults.standard.object(forKey: "endDate") as? Date
}
