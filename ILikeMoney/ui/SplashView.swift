//
//  ContentView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 23/03/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        if isActive {
            OnBoardingView()
        } else {
            NavigationView {
                VStack {
                    VStack {
                        Image("AppLogo").resizable().frame(width: 96, height: 96)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("ILoveMoney").font(.title).padding(.top, 4).bold()
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                                    }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isActive = true
                    }
                }
            }
        }
}

#Preview {
    SplashView()
}
