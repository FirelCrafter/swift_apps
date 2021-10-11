//
//  PostModel.swift
//  swiftGallery
//
//  Created by Михаил Щербаков on 11.10.2021.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var imageName: String
}
