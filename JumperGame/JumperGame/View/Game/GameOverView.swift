//
//  GameOverView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 06.11.2021.
//

import SwiftUI

struct GameOverView: View {
    
    @Binding var isPresented: Bool
    @Binding var bestScore: Int32
    @Binding var totalStairs: Int32
    @Binding var restartGame: Bool
    
    @State var awardsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                
                VStack {
                    
                    Text("GAME OVER")
                        .font(.title.bold())
                        .foregroundColor(Color.white)
                        .padding()
                        .padding(.top, 50)
                    
                    VStack {
                        Text("BEST")
                            .font(.title2.bold())
                            .foregroundColor(Color("HomeText"))
                        Text("\(bestScore)")
                            .font(.title2.bold())
                            .foregroundColor(Color.white)
                    }.padding(.bottom, 20)
                    
                    VStack {
                        Text("TOTAL STAIRS")
                            .font(.title2.bold())
                            .foregroundColor(Color("HomeText"))
                        Text("\(totalStairs)")
                            .font(.title2.bold())
                            .foregroundColor(Color.white)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        
                        Button(action: {
                            restartGame = true
                            isPresented.toggle()
                        }, label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                Image("Ellipse 765")
                            }.frame(width: 56, height: 56)
                        })
                        
                        
                        Button{
                            awardsPresented.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                Image("award")
                            }.frame(width: 56, height: 56)
                        }
                        .fullScreenCover(isPresented: $awardsPresented) {
                            AwardView(isActive: $awardsPresented)
                        }
                        
                        NavigationLink(destination: Home()
                                        .navigationBarBackButtonHidden(true)
                                        .navigationBarHidden(true ),
                                       label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                Image("home")
                            }.frame(width: 56, height: 56)
                        })
                        
                    }
                    .padding(.bottom, 70)
                    
                }
            }.ignoresSafeArea()
        }
    }
}


