//
//  PowerButton.swift
//  MedvedVPN (iOS)
//
//  Created by Михаил Щербаков on 13.09.2021.
//

import SwiftUI

struct PowerButton: View {
    
    let gr1 = Gradient(colors: [
        Color("A"),
        Color("B"),
        Color("C"),
        Color("D"),
        Color("E"),
    ])
    
    let gr2 = Gradient(colors: [
        Color("A"),
        Color("B"),
        Color("C"),
        Color("D"),
        Color("E"),
    ])
    
    @Binding var isConnected: Bool
    
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    isConnected.toggle()
                }
            } label: {
                Image(systemName: "power")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundColor(isConnected ? Color("Light").opacity(0.8) : Color("Text").opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                    .background(
                        ZStack {
                            Circle()
                                .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.5)
                                .stroke(
                                    LinearGradient(gradient: gr1, startPoint: .leading, endPoint: .trailing),
                                    style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                                ).blur(radius: 0.8).shadow(color: Color("E"), radius: 5, x: 1, y: -4)
                            
                            Circle()
                                .trim(from: isConnected ? 0 : 0.7, to: isConnected ? 1 : 0.9)
                                .stroke(
                                    LinearGradient(gradient: gr2, startPoint: .leading, endPoint: .trailing),
                                    style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                                ).blur(radius: 0.8).shadow(color: Color("B"), radius: 5, x: 1, y: -4).rotationEffect(.degrees(30))
                            
                            Circle()
                                .stroke(
                                    Color("B").opacity(0.01),
                                    lineWidth: 11
                                ).shadow(color: Color("B").opacity(isConnected ? 0.04 : 0), radius: 5, x: 1, y: -4).rotationEffect(.degrees(30))
                        }
                    )
            }
        }
        
    }
}

struct PowerButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BG")
                .edgesIgnoringSafeArea(.all)
            PowerButton(isConnected: .constant(false))
        }
    }
}
