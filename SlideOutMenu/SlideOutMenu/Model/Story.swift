//
//  Story.swift
//  SlideOutMenu
//
//  Created by Михаил Щербаков on 20.10.2021.
//

import SwiftUI


struct Story: Identifiable {
    
    var id = UUID().uuidString
    var image: String
    var title: String
    
}

var stories = [
    Story(image: "Pic1", title: "Image in Procreate"),
    Story(image: "Pic2", title: "Image in Procreate"),
    Story(image: "Pic3", title: "Image in Procreate"),
    Story(image: "Pic4", title: "Image in Procreate"),
]
