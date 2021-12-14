//
//  adMobApp.swift
//  adMob
//
//  Created by Михаил Щербаков on 12.12.2021.
//

import SwiftUI
import GoogleMobileAds

@main
struct adMobApp: App {
    
    init() {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
