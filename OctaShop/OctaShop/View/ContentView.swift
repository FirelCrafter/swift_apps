//
//  ContentView.swift
//  OctaShop
//
//  Created by Михаил Щербаков on 01.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var isLoaderVisible = true
    @State var isRedirectVisible = false
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                WebView(type: .public, url: "https://octa-shop.ru", viewModel: viewModel)
                NavigationBarView(viewModel: viewModel)
            }
            
            if isLoaderVisible {
                LoaderView()
            }
            
        }.onReceive(self.viewModel.isLoaderVisible.receive(on: RunLoop.main)) { value in self.isLoaderVisible = value }
        .sheet(isPresented: $isRedirectVisible, content: {
            Text("Redirect")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
