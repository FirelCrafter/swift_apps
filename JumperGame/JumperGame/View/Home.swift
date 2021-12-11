//
//  Home.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @State var pWidth: CGFloat = 320
    @State var pHeight: CGFloat = 480
    @State var isPresented: Bool = false
    @State var selectorPresented: Bool = false
    @State var gamePresented: Bool = false
    @State var awardsPresented: Bool = false
    
    @FetchRequest(entity: Monsters.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Monsters.image, ascending: true)], animation: .spring()) var results : FetchedResults<Monsters>
    
    @FetchRequest(entity: Scores.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Scores.totalStairs, ascending: true)], animation: .spring()) var playerScores : FetchedResults<Scores>
    
    @Environment(\.managedObjectContext) var context
    
    @StateObject var monsterViewModel = MonsterViewModel()
    @StateObject var scoresViewModel = ScoresViewModel()
    
    var body: some View {
            ZStack {
                
                Color("Background")
                
                VStack {
                    
                    // Header
                    VStack {
                        Text("MONSTER")
                            .font(.title.bold())
                            .foregroundColor(.white)
                        Text("TOTAL STAIRS")
                            .font(.title2.bold())
                            .foregroundColor(Color("HomeText"))
                        Text(playerScores.isEmpty ? "0" : "\(playerScores.first!.totalStairs)")
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }.padding(.top, 90)
                    
                    
                    Spacer()
                    
                    // Center
                    
                    
                    Button {
                        gamePresented.toggle()
                    } label: {
                        ZStack {
                            
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 136, height: 136)
                            
                            Circle()
                                .strokeBorder(Color("HomeText"), lineWidth: 5)
                                .frame(width: 136, height: 136)
                            
                            Text("PLAY")
                                .font(.title2.bold())
                                .foregroundColor(Color("PlayButton"))
                                
                        }
                    }
                    .fullScreenCover(isPresented: $gamePresented) {
                        GameView(image: $monsterViewModel.selectedMonster, isPresented: $gamePresented, scoresViewModel: scoresViewModel)
                    }
                    .padding(.bottom, 150)
                    
                    Spacer()
                    
                    // Footer
                    
                    HStack {
                        
                        // Awards
                        
                        Button {
                            awardsPresented.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 80, height: 80)
                                Image("award")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }.fullScreenCover(isPresented: $awardsPresented) {
                            AwardView(isActive: $awardsPresented)
                        }
                        
                        Spacer()
                        
                        // Monster
                        
                        Button {
                            selectorPresented.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 80, height: 80)
                                Image(monsterViewModel.selectedMonster)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }.sheet(isPresented: $selectorPresented) {
                                MonsterListView(isPresented: $selectorPresented, monsterViewModel: monsterViewModel)
                            }
                        }
                        
                        Spacer()
                        
                        
                        // Question
                        
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 80, height: 80)
                                Image("question-mark-circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        
                        
                    }.padding(.bottom, 40).padding(.horizontal, 40)
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                if results.isEmpty {
                    monsterViewModel.fetchMonsters(context: context)
                    monsterViewModel.selectedMonster = "monster1"
                }
                for m in results {
                    if m.isSelected {
                        monsterViewModel.selectedMonster = (m.image ?? "")
                    }
                }
                
                if playerScores.isEmpty {
                    scoresViewModel.fetchScores(context: context)
                } else {
                    playerScores.first!.gameOver = false
                }
                
                print(playerScores)
            }
            .modifier(Popup(isPresented: isPresented, alignment: .center) {
                QuestionView(width: $pWidth, height: $pHeight, isPresented: $isPresented)
            })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
