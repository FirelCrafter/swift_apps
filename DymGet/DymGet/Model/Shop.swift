//
//  Shop.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct Shop: Identifiable {
    
    var id: String
    var name: String
    var city: String
    var logo: String
    var assort: [Item]
    
}

struct Item: Identifiable {
    
    var id: String
    var category: String
    var type: String
    var name: String
    var price: Int
    var image: String
    var description: String
    
}

enum Categories: CaseIterable {
    case hookah, vape
}

func getCategory(cat: Categories) -> String? {
    if cat == Categories.hookah {
        return "Кальян"
    }
    else {
        return "Вейп"
    }
}

enum Items: CaseIterable {
    case hookah, tobacco, vape, liquid, charcoal
}

func getItems(item: Items) -> String? {
    if item == Items.hookah{
        return "Кальян"
    } else if item == Items.tobacco {
        return "Табак"
    } else if item == Items.charcoal {
        return "Уголь"
    } else if item == Items.vape {
        return "Вейп"
    } else {
        return "Жидкость"
    }
}

var shops = [
    
    Shop(id: "1", name: "Дымный папа", city: "Оренбург", logo: "dp", assort: [
        Item(id: "1", category: "Кальяны", type: "Табак", name: "Dark Side", price: 220, image: "dark", description: "Вкус Grape Core"),
        Item(id: "2", category: "Кальяны", type: "Табак", name: "Сарма", price: 290, image: "sarma", description: "Вкус Ананасовый сок")
    ]),
    
]
