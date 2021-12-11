//
//  HomeView.swift
//  MedvedVPN (iOS)
//
//  Created by Михаил Щербаков on 13.09.2021.
//

import SwiftUI

struct HomeView: View {
    
    @State var isConnected = false
    
    //Gesture
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "circle.grid.cross")
                            .font(.title2)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                }
                .overlay(
                    Text(isConnected ? "Connected" : "Disconntected").font(.title2).bold()
                )
                .foregroundColor(Color("Text")).opacity(0.8)
                
                PowerButton(isConnected: $isConnected)
                    .padding(.top, UIScreen.main.bounds.height/10)
                
                if isConnected {
                    
                    withAnimation(.spring()) {
                        StatusBar()
                            .padding(.top, 30)
                    }
                }
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                ZStack {
                    Color("BG")
                        .edgesIgnoringSafeArea(.all)
                    LinearGradient(gradient: Gradient(colors: [Color.black ,Color("BG"), Color("A")]), startPoint: .bottom, endPoint: .top)
                        .opacity(0.3).edgesIgnoringSafeArea(.all)
                    Image("earth")
                        .resizable()
                        .scaledToFill()
                        .offset(y: UIScreen.main.bounds.height/1.8)
                        .opacity(0.5)
                })
            .blur(radius: getBlurRadius())
            
            GeometryReader { proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                return AnyView (
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        
                        VStack {
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 80, height: 4)
                            Text("Server list")
                                .font(.title).bold()
                                .foregroundColor(Color("Text"))
                                .padding()
                        }.frame(maxHeight: .infinity, alignment: .top).padding(.top)
                    }.offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    }).onEnded({ value in
                        let maxHeight = height - 100
                        withAnimation{
                            if -offset > 100 && -offset < maxHeight / 2 {
                                offset = -(maxHeight / 3)
                            } else if -offset > maxHeight / 2 {
                                offset = -maxHeight
                            } else {
                                offset = 0
                            }
                        }
                        
                        lastOffset = offset
                    }))
                )
                
            }.ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 30
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
