//
//  TagModel.swift
//  filterPicker
//
//  Created by Михаил Щербаков on 08.10.2021.
//

import SwiftUI

struct Tag: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}
