//
//  ScoresViewModel.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 04.11.2021.
//

import Foundation
import SwiftUI
import CoreData

class ScoresViewModel: ObservableObject {
    
    @Published var updatedScores: Scores!
    @Published var score: Int32 = 0
    @Published var bestScore: Int32 = 0
    
    func fetchScores(context: NSManagedObjectContext) {
        
        if self.updatedScores != nil {
            self.updatedScores.score = score
            self.updatedScores.totalStairs += 1
            if self.updatedScores.bestScore < bestScore {
                self.updatedScores.bestScore = score
            }
            try! context.save()
            self.updatedScores = nil
            return
        }
        
        let entity = Scores(context: context)
        
        entity.score = newPlayer.score
        entity.bestScore = newPlayer.bestScore
        entity.totalStairs = newPlayer.totalStairs
        entity.gameOver = newPlayer.gameOver
        
        do {
            try context.save()
            print("New player created")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateScores(scores: Scores, context: NSManagedObjectContext) {
        
        self.updatedScores = scores
        fetchScores(context: context)
    }
}
