//
//  PlusButtonView.swift
//  PlusButton (iOS)
//
//  Created by Михаил Щербаков on 21.09.2021.
//

import SwiftUI

struct PlusButtonView: View {
    
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
                ExpandedView(expand: $isAnimating, direction: .bottom, symbolName: "note.text")
                ExpandedView(expand: $isAnimating, direction: .left, symbolName: "doc")
                ExpandedView(expand: $isAnimating, direction: .top, symbolName: "photo")
                ExpandedView(expand: $isAnimating, direction: .right, symbolName: "mic.fill")
            }
            Image(systemName: "plus").font(.system(size: 40, weight: isAnimating ? .regular : .semibold, design: .rounded))
                .foregroundColor(isAnimating ? Color.white : Color.black)
                .rotationEffect(isAnimating ? .degrees(45) : .degrees(0))
                .scaleEffect(isAnimating ? 3 : 1)
                .opacity(isAnimating ? 0.5 : 1)
                .animation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 1))
                .onTapGesture {
                    isAnimating.toggle()
                }
        }
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView()
    }
}
