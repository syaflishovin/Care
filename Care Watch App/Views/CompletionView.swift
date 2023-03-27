//
//  CompletionView.swift
//  Care Watch App
//
//  Created by Angela Christabel on 26/03/23.
//

import SwiftUI

struct CompletionView: View {
    @EnvironmentObject var router: Router
    
    @State private var fadeInOut = false
    @State private var move = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.accentColor]), startPoint: .bottom, endPoint: .top)
                .mask(
                    Circle()
                      .frame(width: 50, height: 50)
                      .blur(radius: 20)
                      .offset(x: -20, y: -20)
                      .rotationEffect(.degrees(move ? 0 : -180))
                      .animation(
                        Animation
                            .linear(duration: 0.3)
                            .speed(0.1)
                      )
                )
            
            VStack {
                Text("Congratulations!")
                    .foregroundColor(.accentColor)
                    .padding()
                Text("You completed your schedule.")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
        }
        .task(delay)
        .onAppear() {
            withAnimation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)) {
                    fadeInOut.toggle()
                    move.toggle()
            }
        }
        .opacity(fadeInOut ? 1 : 0)
        .navigationBarBackButtonHidden(true)
    }
    
    private func delay() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        router.reset()
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
    }
}
