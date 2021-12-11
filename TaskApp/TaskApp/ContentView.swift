//
//  ContentView.swift
//  TaskApp
//
//  Created by Михаил Щербаков on 05.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    

    var body: some View {
        Home()
    }
}
