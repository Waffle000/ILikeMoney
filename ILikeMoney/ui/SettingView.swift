//
//  SettingView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 26/03/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.primaryBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    HStack {
                        Text("Settings").foregroundColor(.white).font(.title2).bold()
                        Spacer()
                    }.padding()
                    
                    NavigationLink(destination: ReminderView(), label: {
                        HStack {
                            Image(systemName: "alarm").foregroundColor(.white).padding(8).background(.blue).cornerRadius(8)
                            Text("Reminder").font(.headline).foregroundColor(.white)
                            Spacer()
                            Image(systemName: "arrow.right").foregroundColor(.white)
                        }.padding(8).background(.secondaryText).cornerRadius(16).padding()
                    })
                }
            }
        }
        
    }
}

#Preview {
    SettingView()
}
