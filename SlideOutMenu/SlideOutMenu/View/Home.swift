//
//  Home.swift
//  SlideOutMenu
//
//  Created by Михаил Щербаков on 20.10.2021.
//

import SwiftUI

struct Home: View {
    
    @State var showMenu: Bool = false
    
    @State var animatePath: Bool = false
    @State var animateBG: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack {
                    Button {
                        withAnimation {
                            animateBG.toggle()
                        }
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3).delay(0.2)){
                            animatePath.toggle()
                        }
                    } label: {
                        Image("menu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 1)
                            .opacity(0.9)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("Add")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 1)
                    }
                }
                .overlay(
                    Text("Stories")
                        .font(.title.bold())
                        .padding(.top)
                )
                .foregroundColor(Color.white.opacity(0.8))
                .padding(.horizontal, 15)
                .padding(.top, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(stories){ story in
                            CardView(story: story)
                        }
                    }.padding().padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color("BG1"), Color("BG2")], startPoint: .top, endPoint: .bottom)
            )
            .ignoresSafeArea()
            
            Color.black
                .opacity(animateBG ? 0.25 : 0)
                .ignoresSafeArea()
            
            MenuView(showMenu: $showMenu, animatePath: $animatePath, animateBG: $animateBG)
                .offset(x: showMenu ? 0 : -getRect().width)
        }
    }
    
    @ViewBuilder
    func CardView(story: Story) -> some View {
        VStack(alignment: .leading, spacing: 12){
            GeometryReader {proxy in
                
                let size = proxy.size
                
                Image(story.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
                
            }.frame(height: 200)
            
            Text(story.title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
            
            Button {
                
            } label: {
                Text("Read Now")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color.red)
                    )
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
