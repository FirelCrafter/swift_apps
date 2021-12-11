//
//  GameView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 02.11.2021.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @State var timerValue: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var image: String
    @Binding var isPresented: Bool
    
    @State var gameOver: Bool = false
    @State var restartGame: Bool = false
    
    @StateObject private var game = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @StateObject private var game1 = GameScene1(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @StateObject private var game2 = GameScene2(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @StateObject private var game3 = GameScene3(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @StateObject private var game4 = GameScene4(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @StateObject private var game5 = GameScene5(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    @ObservedObject var scoresViewModel: ScoresViewModel
    
    @FetchRequest(entity: Scores.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Scores.totalStairs, ascending: true)], animation: .spring()) var playerScores : FetchedResults<Scores>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
            ZStack(alignment: .topLeading) {
                
                if gameOver {
                    GameOverView(isPresented: $gameOver, bestScore: $scoresViewModel.bestScore, totalStairs: $scoresViewModel.score, restartGame: $restartGame)
                } else {
                    if image == "monster1" {
                        SpriteView(scene: game)
                    } else if image == "monster2" {
                        SpriteView(scene: game1)
                    } else if image == "monster3" {
                        SpriteView(scene: game2)
                    } else if image == "monster4" {
                        SpriteView(scene: game3)
                    } else if image == "monster5" {
                        SpriteView(scene: game4)
                    } else if image == "monster6" {
                        SpriteView(scene: game5)
                    }

                
                Button {
                    isPresented.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: UIScreen.main.bounds.width / 18,
                                   height: UIScreen.main.bounds.height / 18)
                        
                        Image(systemName: "chevron.left")
                            .font(.title.bold())
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, UIScreen.main.bounds.width/25)
                    .padding(UIScreen.main.bounds.height/25)
                        
                }
                
                VStack {
                    
                    VStack {
                        Text("TIMER")
                        Text("\(timerValue)")
                            .onReceive(timer) { _ in
                                timerValue += 1
                            }
                    }
                    .font(.title.bold())
                    .foregroundColor(Color.white)
                    
                    VStack {
                        Text("SCORE")
                        Text("\(scoresViewModel.score)")
                    }
                    .font(.title.bold())
                    .foregroundColor(Color("HomeText"))
                    
                    
                }
                .padding()
                .position(x: UIScreen.main.bounds.width / 2,
                          y: UIScreen.main.bounds.height / 6)
                
                }
                
            }
            .ignoresSafeArea()
            .onChange(of: game.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game1.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game2.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game3.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game4.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game5.stairsCounter) { point in
                
                scoresViewModel.score = point
                scoresViewModel.bestScore = point
                scoresViewModel.updateScores(scores: playerScores.first!, context: context)
            }
            .onChange(of: game.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: game1.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: game2.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: game3.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: game4.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: game5.gameOver) { value in
                scoresViewModel.bestScore = playerScores.first!.bestScore
                gameOver.toggle()
            }
            .onChange(of: restartGame) { value in
                if value == true {
                    game.gameOver = false
                    game1.gameOver = false
                    game2.gameOver = false
                    game3.gameOver = false
                    game4.gameOver = false
                    game5.gameOver = false
                    scoresViewModel.score = 0
                    timerValue = 0
                    scoresViewModel.updateScores(scores: playerScores.first!, context: context)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        restartGame = false
                        print("gameover: \(game.gameOver), restart: \(restartGame)")
                    }
                }
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
