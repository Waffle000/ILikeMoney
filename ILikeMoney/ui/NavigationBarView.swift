//
//  NavigationBarView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 25/03/24.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        TabView {
            OverviewView().tabItem() {
                Image(systemName: "arrow.up.and.down.and.sparkles")
                Text("Overview")
            }
            ReportView().tabItem() {
                Image(systemName: "note.text")
                Text("Report")
            }
            ReminderView().tabItem {
                Image(systemName: "alarm")
                Text("Reminder")
            }
        }.navigationBarBackButtonHidden(true).accentColor(.secondaryBackground)
    }
}

#Preview {
    NavigationBarView()
}
