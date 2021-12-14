//
//  Home.swift
//  adMob
//
//  Created by Михаил Щербаков on 12.12.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        if #available(iOS 15.0, *) {
            ScrollView(.vertical, showsIndicators: false) {
                
                let adPlacement: Int = 5
                
                VStack(spacing: 20) {
                    
                    ForEach(1...24, id: \.self) { index in
                        
                        CardView(index: index)
                        
                        if (index % adPlacement) == 0 {
                            BannerAd(unitID: "ca-app-pub-3663461982705268/8134604372")
                        }
                        
                    }
                    
                }
                .padding()
                
            }
            .safeAreaInset(edge: .top) {
                HStack {
                    Button {
                        
                    } label: {
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .overlay(
                    Text("Taddy")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                )
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 2)
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @ViewBuilder
    func CardView(index: Int) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            GeometryReader { proxy in
                let size = proxy.size
                
                Image("Post\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
                
            }
            .frame(height: 250)
            
            HStack(spacing: 15) {
                
                Group {
                    ForEach(["heart", "message", "paperplane", "bookmark"], id: \.self) { image in
                        
                        if image == "bookmark" {
                            Spacer()
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: image)
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                    }
                }
                
            }
            
            Text("\(Int.random(in: 10...60)) Likes")
                .font(.callout)
                .fontWeight(.semibold)
            
            Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
                .font(.callout)
                .lineLimit(3)
            
        }
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
