//
//  ContentView.swift
//  Elevator
//
//  Created by Михаил Щербаков on 03/07/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Elevator()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12").previewDisplayName("iPhone 12")
        ContentView().previewDevice("iPad Pro (9.7-inch)").previewDisplayName("iPad Pro (9.7-inch)")
    }
}
