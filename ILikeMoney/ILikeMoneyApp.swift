//
//  ILikeMoneyApp.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 23/03/24.
//

import SwiftUI
import SwiftData

@main
struct ILikeMoneyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
           
        UITabBar.appearance().barTintColor = UIColor.primaryBackground
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.secondaryBackground
        UINavigationBar.appearance().barTintColor = UIColor.primaryBackground
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        }
    var body: some Scene {
        WindowGroup {
            SplashView()
        }.modelContainer(for: [IncomeCategory.self, SpendingCategory.self, Money.self, Alarm.self])
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Dispatch")
            AppState.shared.pageToNavigationTo = "test"
        }
        
        return true
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var pageToNavigationTo : String?
}

