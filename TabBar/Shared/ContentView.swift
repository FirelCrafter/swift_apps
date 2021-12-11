//
//  ContentView.swift
//  Shared
//
//  Created by Михаил Щербаков on 09.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        GeometryReader { proxy in
            
            let size = proxy.size
            let bottomEdge = proxy.safeAreaInsets.bottom
            
            HomeScreenView(size: size, bottomEdge: bottomEdge)
                .ignoresSafeArea(.all, edges: .bottom)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
