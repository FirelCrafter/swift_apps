//
//  PostData.swift
//  HackerNews
//
//  Created by Михаил Щербаков on 11.01.2022.
//

import SwiftUI

struct Results: Decodable {
    
    let hits: [Post]
    
}

struct Post: Decodable, Identifiable {
    
    var id: String {
        return objectID
    }
    
    let objectID: String
    let points: Int
    let title: String
    let url: String?
    
}
