//
//  DateValue.swift
//  TodoDatePicker
//
//  Created by Михаил Щербаков on 30.09.2021.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
