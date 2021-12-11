//
//  LoaderView.swift
//  OctaShop
//
//  Created by Михаил Щербаков on 01.10.2021.
//

import SwiftUI

struct LoaderView: View {
    
    @State var isSpinCircle = false
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                ZStack {
                        Circle()
                            .frame(width: 60, height: 60, alignment: .center)
                            .foregroundColor(.white)
                        
                        VStack {
                            Circle()
                                .frame(width: 200, height: 200)
                            Circle()
                                .trim(from: 0.3, to: 1)
                                .stroke(Color(.red), lineWidth: 8)
                                .frame(width:50, height: 50)
                                .padding(.all, 8)
                                .rotationEffect(.degrees(isSpinCircle ? 0 : -360), anchor: .center)
                                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
                                .onAppear {
                                    self.isSpinCircle = true
                                }
                            
                        }
                }
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
