//
//  CustomTabBar.swift
//  TabBar (iOS)
//
//  Created by Михаил Щербаков on 09.09.2021.
//

import SwiftUI

struct CustomTabBar: View {
    
    var animation: Namespace.ID
    
    var size: CGSize
    var bottomEdge: CGFloat
    
    @Binding var currentTab: Tab
    
    @State var startAnimation: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {tab in
                TabButtonView(tab: tab, animation: animation, currentTab: $currentTab) { pressedTab in
                    
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        startAnimation = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            currentTab = pressedTab
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            startAnimation = false
                        }
                    }
                }
            }
        }
        .background(
            ZStack {
                
                let animationOffset : CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
                
                let offset : CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) : CGSize(width: animationOffset, height: 36)
                
                Rectangle()
                    .fill(Color("Purple"))
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: offset.width, y: offset.height)
                Circle()
                    .fill(Color.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: -offset.width, y: offset.height)
            }
            .offset(x: getStartOffset())
            .offset(x: getOffset())
            ,alignment: .leading
        )
        .padding(.horizontal, 15)
        .padding(.top, 7)
        .padding(.bottom, bottomEdge == 0 ? 23 : bottomEdge)
    }
    
    func getStartOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
        let center = (reduced - 45) / 2
        return center
    }
    func getOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
        let index = Tab.allCases.firstIndex { checkTab in
            return checkTab == currentTab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewDevice("iPhone 8")
    }
}
