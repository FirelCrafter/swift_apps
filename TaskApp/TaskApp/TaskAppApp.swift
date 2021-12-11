//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by Михаил Щербаков on 05.10.2021.
//

import SwiftUI

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
