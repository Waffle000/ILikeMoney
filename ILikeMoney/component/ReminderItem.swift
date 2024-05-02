//
//  ReminderItem.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 26/03/24.
//

import SwiftUI

struct ReminderItem: View {
    @ObservedObject var viewModel = ReminderViewModel()
    @Bindable var alarm : Alarm
    @Environment(\.modelContext) var context
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(itemFormatter.string(from: alarm.time)).font(.title2).foregroundColor(.white).bold()
                Text(alarm.note).foregroundColor(.white).font(.callout)
            }
            Spacer()
            Toggle("", isOn: $alarm.isSelected).onChange(of: alarm.isSelected) { oldValue, newValue in
                
                print("Alarm changed from \(oldValue ? "ON" : "OFF") to \(newValue ? "ON" : "OFF")")
                if alarm.isSelected {
                    viewModel.addAlarm(for: alarm)
                } else {
                    viewModel.removeAlarm(alarmId: alarm.id)
                }
                print(alarm.isSelected)
             
            }
        }.padding()
    }
}
