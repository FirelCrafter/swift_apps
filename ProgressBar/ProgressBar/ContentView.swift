//
//  ContentView.swift
//  ProgressBar
//
//  Created by Михаил Щербаков on 15.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var amount: CGFloat = 13200
    @State var total: CGFloat = 25000
    
    
    var body: some View {
        VStack {
            ProgressBar(amount: $amount, total: $total)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
