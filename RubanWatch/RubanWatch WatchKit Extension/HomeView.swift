//
//  HomeView.swift
//  RubanWatch WatchKit Extension
//
//  Created by Михаил Щербаков on 28/07/2021.
//

import SwiftUI

struct HomeView: View {
    let grad = LinearGradient(gradient: Gradient(colors:[.purple, .pink, .orange]), startPoint: .topTrailing, endPoint: .topLeading)
    @State var showLine = false
    @State var showText = false
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: showLine ? 0.1 : 0.99, to: 1)
                    .stroke(grad, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(90))
                    .rotation3DEffect(
                        Angle(degrees: 180),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    .frame(width: 100, height: 100)
                    .animation(.easeOut(duration: 1.0))
                
                VStack {
                    Text("386")
                        .font(.title2)
                    Text("шагов")
                        .font(.caption2)
                }
                .animation(.easeOut(duration: 1.0))
            }
            .padding(.bottom, 10)
            if showText {
                VStack {
                    HStack(alignment: .center) {
                        Text("Потрачено калорий")
                            .font(.system(size: 10))
                        Spacer()
                        Text("925/1000")
                            .font(.system(size: 12))
                    }.padding(.bottom, 3)
                    
                    HStack(alignment: .center) {
                        Text("КБЖУ сегодня")
                            .font(.system(size: 10))
                        Spacer()
                        Text("1000/80/20/40")
                            .font(.system(size: 12))
                    }
                    
                }.padding(.horizontal)
            }
        }
        .onAppear() {
            self.showLine.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.showText.toggle()
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
