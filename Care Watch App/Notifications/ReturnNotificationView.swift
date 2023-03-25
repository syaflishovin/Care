//
//  ReturnNotificationView.swift
//  Care Watch App
//
//  Created by Syafli Shovin on 25/03/23.
//

import SwiftUI

struct ReturnNotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LottieViewModel = .init()
    
    var body: some View {
        Image(uiImage: viewModel.image)
                        .resizable()
                        .onAppear {
                                   self.viewModel.loadAnimationFromFile(filename: "Animation")
                               }
                        .scaledToFit()
                        
//                        .ignoresSafeArea(.all)
                        
                        
    }
}

struct ReturnNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ReturnNotificationView()
    }
}
