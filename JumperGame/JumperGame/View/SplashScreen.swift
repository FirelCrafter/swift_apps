//
//  SplashScreen.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            
            Color("Background")
            
            VStack {
                ZStack {
                    Image("1")
                    Image("3")
                    Image("2")
                    Image("4")
                        .offset(x: -3, y: -18)
                }
                Image("Monster")
                    .padding(.vertical, 40)
            }
            
        }.ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
