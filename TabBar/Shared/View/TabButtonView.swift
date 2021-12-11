//
//  TabButtonView.swift
//  TabBar (iOS)
//
//  Created by Михаил Щербаков on 09.09.2021.
//

import SwiftUI

struct TabButtonView: View {
    
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    
    var onTap: (Tab) -> ()
    
    var body: some View {
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab {
                    onTap(tab)
                }
            }
    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
