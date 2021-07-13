//
//  SideMenu.swift
//  RubanApp
//
//  Created by Михаил Щербаков on 10/07/2021.
//

import SwiftUI

struct SideMenu: View {
    @ObservedObject var viewData : HomeViewModel
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.horizontal)
                
                Text("Fitmenchef")
                    .font(.title2)
                
                Spacer(minLength: 0)
            }
            
            NavigationLink(
                destination: CartView(viewData: viewData),
                label: {
                    HStack {
                        
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Text("Корзина")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                    }.padding([.all, .horizontal])
                })
            
            Spacer()
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}
