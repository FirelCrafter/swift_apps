//
//  MonsterListView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 01.11.2021.
//

import SwiftUI
import CoreData


struct MonsterListView: View {
    
    @Binding var isPresented: Bool
    
    @ObservedObject var monsterViewModel: MonsterViewModel
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Monsters.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Monsters.image, ascending: true)], animation: .spring()) var results : FetchedResults<Monsters>
    
    @FetchRequest(entity: Scores.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Scores.totalStairs, ascending: true)], animation: .spring()) var playerScores : FetchedResults<Scores>
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            
            Color("Background")
            
            VStack {
                
                Text("CHARACTERS")
                    .font(.title.bold())
                    .foregroundColor(Color.white)
                
                ZStack {
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 296, height: 352)
                        .cornerRadius(10)
                    
                    VStack {
                        
                        Text("TOTAL STAIRS: \(playerScores.isEmpty ? 0 : playerScores.first!.totalStairs)")
                            .font(.title2.bold())
                            .foregroundColor(Color.white)
                            .padding()
                        
                        ScrollView {
                            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                                ForEach(results) { mon in
                                    Button {
                                        monsterViewModel.selectedMonster = (mon.image ?? "")
                                        for m in results {
                                            monsterViewModel.updatedMonster = m
                                            if m.image == monsterViewModel.selectedMonster {
                                                monsterViewModel.updateSelection = true
                                                monsterViewModel.fetchMonsters(context: context)
                                            } else {
                                                monsterViewModel.updateSelection = false
                                                monsterViewModel.fetchMonsters(context: context)
                                            }
                                        }
                                    } label: {
                                        Image(mon.image ?? "")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .padding()
                                            .opacity(mon.isSelected ? 1 : 0.3)
                                    }
                                }
                            }
                        }.frame(width: 200)
                        
                        Text("TAP ON A CHARACTER")
                            .font(.title2.bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.white)
                                    
                                Image("home")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            .padding(.bottom)
                        }
                        
                    }
                    
                    
                }
                .frame(width: 296, height: 352)
            }
            
        }.ignoresSafeArea()
    }
}

struct MonsterListView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
