//
//  SplashScreen.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            
            Color.black
            
            VStack {
                ZStack {
                    
                    Image("Logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                    
                    EmitterView(images: ["spark"], particleCount: 300, colors: [.gray], blendMode: .screen, angleRange: .degrees(40), opacitySpeed: 0.9, scale: 0.02, scaleRange: 0.01, scaleSpeed: 1, speed: 15, speedRange: 90, animation: Animation.linear(duration: 0.5).repeatForever(autoreverses: false), animationDelayTreshold: 1).opacity(0.07).offset(y: -145)
                    
                }.frame(height: UIScreen.main.bounds.height / 2)
                
                Text("DымGet")
                    .font(.custom("StalinistOne-Regular", size: 40))
                    .foregroundColor(Color.white)
            }
            
            
        }.ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
