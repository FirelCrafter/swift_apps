//
//  FaceIDApp.swift
//  FaceID
//
//  Created by Михаил Щербаков on 04.01.2022.
//

import SwiftUI
import Firebase

@main
struct FaceIDApp: App {
    
    // MARK: Firebase
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Delegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}
