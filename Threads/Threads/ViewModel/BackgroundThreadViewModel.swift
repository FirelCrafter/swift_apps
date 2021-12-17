//
//  BackgroundThreadViewModel.swift
//  Threads
//
//  Created by Михаил Щербаков on 17.12.2021.
//

import SwiftUI


class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            
            // For debug
            
            print("DEBUG: \(Thread.isMainThread)")
            print("DEBUG: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 1..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
    
}
