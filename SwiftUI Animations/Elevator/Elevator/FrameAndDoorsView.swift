//
//  FrameAndDoorsView.swift
//  Elevator
//
//  Created by Михаил Щербаков on 03/07/2021.
//

import SwiftUI

struct FrameAndDoorsView: View {
    
    @Binding var doorsOpened: Bool
    
    var body: some View {
        ZStack {
            GeometryReader {geo in
                HStack {
                    Image("leftDoor")
                        .resizable()
                        .frame(width: geo.size.width/2)
                        .offset(x: doorsOpened ? -geo.size.width / 2 : 4)
                    Image("rightDoor")
                        .resizable()
                        .frame(width: geo.size.width/2)
                        .offset(x: doorsOpened ? geo.size.width / 2 : -4)
                }
                Image("doorFrame")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
            }.animation(Animation.easeInOut.speed(0.09).delay(0.3))
        }
    }
}

struct FrameAndDoorsView_Previews: PreviewProvider {
    static var previews: some View {
        FrameAndDoorsView(doorsOpened: .constant(false))
    }
}
