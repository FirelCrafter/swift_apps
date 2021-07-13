//
//  Item.swift
//  RubanApp
//
//  Created by Михаил Щербаков on 10/07/2021.
//

import SwiftUI

struct Item: Identifiable {
    
    var id: String
    var itemName: String
    var itemCost: NSNumber
    var itemDetails: String
    var itemImage: String
    var itemRatings: String
    var isAdded: Bool = false
    
}
