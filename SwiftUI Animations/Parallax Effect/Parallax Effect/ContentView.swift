//
//  ContentView.swift
//  Parallax Effect
//
//  Created by Михаил Щербаков on 03/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animate1 = false
    @State private var animate2 = false
    
    var body: some View {
        
        ZStack {
            //MARK: - background
            
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .colorInvert()
                .edgesIgnoringSafeArea(.all)
            
            //MARK: - Title
            
            VStack {
                Text("Parallax effect")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 80)
                
                //MARK: - Image 1
                
                VStack {
                    Image("wolf")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(25)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                }.rotation3DEffect(
                    .degrees(animate1 ? 13: -13),
                    axis: (x: animate1 ? 90 : -45, y: animate1 ? -45 : -90, z: 0))
                .animation(Animation.easeInOut(duration: 3.5).repeatForever(autoreverses: true))
                .onAppear() {
                    animate1.toggle()
                }.padding(30)
                
                //MARK: - Image 2
                
                VStack {
                    Image("cube")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(25)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                }.rotation3DEffect(
                    .degrees(animate1 ? 13: -13),
                    axis: (x: animate1 ? 90 : -45, y: animate1 ? -45 : -90, z: 0))
                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
                .onAppear() {
                    animate2.toggle()
                }.padding(30)
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
