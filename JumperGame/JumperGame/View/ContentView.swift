//
//  ContentView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State var main: Bool = false
    var body: some View {
        ZStack {
            
            if main {
                Home()
            } else {
                SplashScreen()
            }
        }
        .ignoresSafeArea()
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.spring()) {
                    main.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
