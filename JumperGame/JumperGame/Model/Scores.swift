//
//  Scores.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 04.11.2021.
//

import SwiftUI

struct ScoresModel: Identifiable {
    
    var id: String
    var score: Int32
    var bestScore: Int32
    var totalStairs: Int32
    var gameOver: Bool
}


var newPlayer = ScoresModel(id: "1", score: 0, bestScore: 0, totalStairs: 0, gameOver: false)
