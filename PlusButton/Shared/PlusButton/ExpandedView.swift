//
//  ExpandedView.swift
//  PlusButton (iOS)
//
//  Created by Михаил Щербаков on 21.09.2021.
//

import SwiftUI

struct ExpandedView: View {
    
    @Binding var expand: Bool
    var direction: ExpandDirection
    var symbolName: String
    
    var body: some View {
        ZStack {
            ZStack {
                Image(systemName: symbolName)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(Color.black).padding()
                    .scaleEffect(expand ? 1: 0)
                    .rotationEffect(expand ? .degrees(-43): .degrees(0))
                    .animation(.easeOut(duration: 0.15))
            }
            .frame(width: 82, height: 82)
            .background(Color.white)
            .cornerRadius(expand ? 41 : 8)
            .scaleEffect(expand ? 1 : 0.5)
            
            .offset(x: expand ? direction.offsets.0 : 0, y: expand ? direction.offsets.1 : 0)
            .rotationEffect(expand ?  .degrees(43) : .degrees(0))
            .animation(.easeOut(duration: 0.25).delay(0.05))
        }.offset(x: direction.containerOffset.0, y: direction.containerOffset.1)
    }
}

struct ExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedView(expand: .constant(true), direction: .bottom, symbolName: "doc.fill")
    }
}
