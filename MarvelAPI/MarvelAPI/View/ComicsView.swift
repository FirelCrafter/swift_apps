//
//  ComicsView.swift
//  MarvelAPI
//
//  Created by Михаил Щербаков on 13.12.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsView: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeData.fetchedComics.isEmpty {
                    ProgressView()
                        .padding(.top, 20)
                } else {
                    VStack(spacing: 15) {
                        ForEach(homeData.fetchedComics) { comic in
                            ComicRowView(character: comic)
                        }
                        
                        if homeData.offset == homeData.fetchedComics.count {
                            
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    print("Getting new data")
                                    homeData.searchComics()
                                })
                            
                        } else {
                            GeometryReader { reader -> Color in
                                
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    
                                    print("Last")
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                    
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }.padding(.vertical)
                }
            }
            .navigationTitle("Marvel's comics")
        }
        .onAppear(perform: {
            if homeData.fetchedComics.isEmpty {
                homeData.searchComics()
            }
        })
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
    }
}


struct ComicRowView: View {
    
    var character: Comic
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            
            WebImage(url: extractImage(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(character.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let description = character.descrition {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 10) {
                    
                    ForEach(character.urls, id: \.self) { data in
                        
                        NavigationLink(destination: WebView(url: extractURL(data: data)).navigationTitle(extractURLType(data: data)),
                                       label: {
                            Text(extractURLType(data:data))
                        })
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    func extractImage(data: [String: String]) -> URL {
        
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
        
    }
    
    func extractURL(data: [String: String]) -> URL {
        
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String: String]) -> String {
        
        let type = data["type"] ?? ""
        
        return type.capitalized
        
    }
}
