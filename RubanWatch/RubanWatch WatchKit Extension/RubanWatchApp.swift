//
//  RubanWatchApp.swift
//  RubanWatch WatchKit Extension
//
//  Created by Михаил Щербаков on 28/07/2021.
//

import SwiftUI

@main
struct RubanWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
