//
//  ContentView.swift
//  RubanWatch WatchKit Extension
//
//  Created by Михаил Щербаков on 28/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var animate = false
    @State var home = false
    var body: some View {
        VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                Text("Fitmenchef")
                    .font(.title2)
                
                HStack {
                    Text("Tap to start")
                        .font(.caption)
                    Image(systemName: "chevron.right")
                }.opacity(animate ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
            }
                .foregroundColor(.white)
                .onAppear() { self.animate.toggle() }
                .fullScreenCover(isPresented: $home, content: { HomeView() })
        .onTapGesture {
            self.home.toggle()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
