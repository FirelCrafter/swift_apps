//
//  ContentView.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State var showHome: Bool = false
    var body: some View {
        ZStack {
            
            SplashScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.spring()){
                            showHome.toggle()
                        }
                    }
                }
            
            if showHome {
                Home()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
