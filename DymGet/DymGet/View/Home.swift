//
//  Home.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct Home: View {
    
    @State var showMenu: Bool = false
    
    @State var animatePath: Bool = false
    @State var animateBG: Bool = false
    @State var shopDetail: Bool = false
    
    @StateObject var viewModel = HomeViewModel()
    
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
                        Image("Logo")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 1)
                            .opacity(0.9)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .shadow(radius: 1)
                            .padding()
                    }
                }
                .overlay(
                    Text("Магазины")
                        .font(.title.bold())
                        .padding(.top)
                )
                .foregroundColor(Color.white.opacity(0.8))
                .padding(.horizontal, 15)
                .padding(.top, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(shops){ shop in
                            Button {
                                shopDetail.toggle()
                            } label: {
                                ShopView(shop: shop)
                                    .fullScreenCover(isPresented: $shopDetail) {
                                        ShopDetailView(shopPresented: $shopDetail, shop: shop)
                                    }
                            }
                            Divider()
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
            
            MenuView(showMenu: $showMenu, animatePath: $animatePath, animateBG: $animateBG, viewModel: viewModel)
                .offset(x: showMenu ? 0 : -getRect().width)
        }
        .onAppear {
            viewModel.locationManager.delegate = viewModel
            viewModel.locationManager.requestWhenInUseAuthorization()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
