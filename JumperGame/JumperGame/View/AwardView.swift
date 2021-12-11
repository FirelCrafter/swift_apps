//
//  AwardView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 08.11.2021.
//

import SwiftUI

struct AwardView: View {
    
    @FetchRequest(entity: Scores.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Scores.totalStairs, ascending: true)], animation: .spring()) var playerScores : FetchedResults<Scores>
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color("Background")
            
            VStack {
                
                VStack {
                    Text("BEST")
                        .font(.title2.bold())
                        .foregroundColor(Color("HomeText"))
                    Text("\(playerScores.first!.bestScore)")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                }.padding(.bottom, 20)
                
                VStack {
                    Text("TOTAL STAIRS")
                        .font(.title2.bold())
                        .foregroundColor(Color("HomeText"))
                    Text("\(playerScores.first!.totalStairs)")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    
                    Button {
                        isActive.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                            Image("home")
                        }.frame(width: 56, height: 56)
                    }
                    
                }
                .padding(.bottom, 70)
                
            }.padding(.vertical, 100)
        }.ignoresSafeArea()
    }
}

