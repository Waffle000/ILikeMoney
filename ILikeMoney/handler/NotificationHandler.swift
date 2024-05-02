//
//  NotificationHandler.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else  if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func hasNotificationPermission(completion: @escaping (Bool) -> Void) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                    if settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional {
                        // Izin telah diberikan
                        completion(true)
                    } else if settings.authorizationStatus == .notDetermined {
                      
                        completion(false)
                    } else {
                   
                        completion(false)
                    }
                }
            }
        }
    }
