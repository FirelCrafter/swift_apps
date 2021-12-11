//
//  MonsterViewModel.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI
import CoreData

class MonsterViewModel: ObservableObject {
    
    @Published var selectedMonster: String = "monster1"
    @Published var monsterSelection: [Monster] = []
    @Published var updateSelection: Bool = false
    @Published var updatedMonster: Monsters!
    
    func fetchMonsters(context: NSManagedObjectContext) {
        
        if self.updatedMonster != nil {
            self.updatedMonster.isSelected = updateSelection
            try! context.save()
            print("monster \(updatedMonster.image) updated to \(updateSelection)")
            self.updatedMonster = nil
            return
        }
        
        monsterList.forEach { (monster) in
            
            let entity = Monsters(context: context)
            
            entity.image = monster.image
            entity.isSelected = monster.isSelected
            
        }
        
        do {
            try context.save()
            print("Monsters saved")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func updateMonster(context: NSManagedObjectContext, monster: Monsters) {
        
        monster.isSelected = self.updateSelection
        try! context.save()
    }
    

}
