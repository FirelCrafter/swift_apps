//
//  HomeScreenView.swift
//  TabBar (iOS)
//
//  Created by Михаил Щербаков on 09.09.2021.
//

import SwiftUI

struct HomeScreenView: View {
    
    @State var currentTab: Tab = .Home
    @Namespace var animation
    
    var size: CGSize
    var bottomEdge: CGFloat
    
    init(size: CGSize, bottomEdge: CGFloat) {
        
        self.size = size
        self.bottomEdge = bottomEdge
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                
                Text("Home")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea(.all))
                    .tag(Tab.Home)
                Text("Search")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea(.all))
                    .tag(Tab.Search)
                Text("Liked")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea(.all))
                    .tag(Tab.Liked)
                Text("Settings")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea(.all))
                    .tag(Tab.Settings)
            }
            
            CustomTabBar(animation: animation, size: size, bottomEdge: bottomEdge, currentTab: $currentTab)
                .background(Color.white)
        }
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
