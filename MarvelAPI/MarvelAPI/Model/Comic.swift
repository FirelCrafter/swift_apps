//
//  Comic.swift
//  MarvelAPI
//
//  Created by Михаил Щербаков on 13.12.2021.
//

import SwiftUI

struct APIComicResult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    
    var id: Int
    var title: String
    var descrition: String?
    var thumbnail: [String: String]
    var urls: [[String: String]]
    
}
