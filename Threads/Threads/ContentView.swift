//
//  ContentView.swift
//  Threads
//
//  Created by Михаил Щербаков on 17.12.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            
            LazyVStack(spacing: 10) {
                
                Text("Load Data...")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        viewModel.fetchData()
                    }
                
                ForEach(viewModel.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
