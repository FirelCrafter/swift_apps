//
//  ShopDetailView.swift
//  DymGet
//
//  Created by Михаил Щербаков on 22.10.2021.
//

import SwiftUI

struct ShopDetailView: View {
    
    @Binding var shopPresented: Bool
    
    var shop: Shop
    
    @StateObject var viewModel = ShopViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        shopPresented.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text(shop.name)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                    }
                }
                .font(.title.bold())
                .foregroundColor(Color.white).opacity(0.8)
                .padding(.top, 30)
                .padding()
                
                ScrollView {
                    Rectangle()
                        .foregroundColor(Color.white).opacity(0.8)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 3)
                    Text("Табаки")
                        .font(.title.bold())
                        .foregroundColor(Color.white).opacity(0.8)
                    
                    ForEach(shop.assort){item in
                        ItemView(item: item)
                    }
                    
                }
            }
        }
        .background(
            LinearGradient(colors: [Color("BG1"), Color("BG2")], startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea()
    }
}

struct ShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailView(shopPresented: .constant(true), shop: shops[0])
    }
}
