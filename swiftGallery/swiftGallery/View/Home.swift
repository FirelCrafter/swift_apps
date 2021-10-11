//
//  Home.swift
//  swiftGallery
//
//  Created by Михаил Щербаков on 11.10.2021.
//

import SwiftUI

struct Home: View {
    
    @State var posts: [Post] = []
    @State var currentPost: String = ""
    @State var fullPreview: Bool = false
    
    
    var body: some View {
        TabView(selection: $currentPost) {
            
            ForEach(posts) { post in
                GeometryReader {proxy in
                    
                    let size = proxy.size
                    
                    Image(post.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(0)
                }.ignoresSafeArea().tag(post.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                fullPreview.toggle()
            }
        }
        
        .overlay(
            HStack {
                Text("Space Gallery")
                    .font(.title2.bold())
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                }
            }
                .foregroundColor(.white)
                .padding()
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                .offset(y: fullPreview ? -150 : 0),
            alignment: .top
            
        )
        
        // Bottom image list
        
        .overlay(
            ScrollViewReader {proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) { post in
                            Image(post.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 60)
                                .cornerRadius(12)
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.white, lineWidth: 2)
                                        .opacity(currentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }.padding()
                }
                .frame(height: 80)
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                .onChange(of: currentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .bottom)
                    }
                }
            }
                .offset(y: fullPreview ? 150 : 0),
            alignment: .bottom
        )
        
        .onAppear {
            for index in 1...12 {
                posts.append(Post(imageName: "post\(index)"))
            }
            currentPost = posts.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
