//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Михаил Щербаков on 11.01.2022.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let resuls = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.sync {
                                self.posts = resuls.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
            
            task.resume()
        }
        
    }
}
