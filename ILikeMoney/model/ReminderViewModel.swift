//
//  ReminderViewModel.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import UserNotifications

class ReminderViewModel : ObservableObject {
    @Published var isEnable: Bool = false
    @Published var alarms: [Alarm] = []

    func addAlarm(for alarm: Alarm) {
        scheduleNotification(time: alarm.time, id: alarm.id, note: alarm.note)
    }
    
    func addReminder(for alarm: Alarm) {
        scheduleNotification(time: alarm.time, id: alarm.id, note: alarm.note)
        isEnable = true
    }
    
    func removeAlarm(alarmId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmId])
        alarms.removeAll { $0.id == alarmId }
    }

    private func scheduleNotification(time: Date, id: String, note: String) {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "Dont forget your financial"
        content.body = "Before \(note), let's make a financial note first"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
