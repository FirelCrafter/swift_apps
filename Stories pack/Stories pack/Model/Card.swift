//
//  Card.swift
//  Stories pack
//
//  Created by Михаил Щербаков on 13.11.2021.
//

import SwiftUI


struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var date: String = ""
    var title: String
    
}



