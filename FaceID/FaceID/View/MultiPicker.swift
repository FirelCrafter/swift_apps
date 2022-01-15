//
//  MultiPicker.swift
//  FaceID
//
//  Created by Михаил Щербаков on 05.01.2022.
//

import SwiftUI

struct MultiPicker: View  {
    
    // MARK: - Stored Properties

    typealias Label = String
    typealias Entry = String

    let data: [(Label, [Entry])]
    @Binding private(set) var selection: [Entry]
    
    // MARK: - Views

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                ForEach(0..<data.count) { column in
                    Picker(
                        data[column].0,
                        selection: $selection[column]
                    ) {
                        ForEach(0..<data[column].1.count) { row in
                            Text(verbatim: data[column].1[row])
                                .tag(data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(
                        width: geometry.size.width / CGFloat(data.count),
                        height: geometry.size.height
                    )
                    .compositingGroup()
                    .clipped()
                }
            }
        }
    }
    
}
