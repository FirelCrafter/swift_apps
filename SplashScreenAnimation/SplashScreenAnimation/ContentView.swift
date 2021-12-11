//
//  ContentView.swift
//  SplashScreenAnimation
//
//  Created by Михаил Щербаков on 19.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var endAnimation: Bool = false
    
    var body: some View {
        ZStack {
            
            Home()
                .offset(y: endAnimation ? 0 : getRect().height)
            
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
