//
//  Router.swift
//  Care Watch App
//
//  Created by Angela Christabel on 26/03/23.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
}
