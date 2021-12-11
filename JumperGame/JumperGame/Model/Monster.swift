//
//  Monster.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI


struct Monster: Identifiable {
    
    var id: String
    var image: String
    var isSelected: Bool
    
}

var monsterList = [
    
    Monster(id: "1", image: "monster1", isSelected: true),
    Monster(id: "2", image: "monster2", isSelected: false),
    Monster(id: "3", image: "monster3", isSelected: false),
    Monster(id: "4", image: "monster4", isSelected: false),
    Monster(id: "5", image: "monster5", isSelected: false),
    Monster(id: "6", image: "monster6", isSelected: false)
    
]
