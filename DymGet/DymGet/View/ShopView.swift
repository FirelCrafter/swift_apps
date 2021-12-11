//
//  ShopView.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct ShopView: View {
    
    @State private var isPresented: Bool = false
    
    var shop: Shop
    
    
    var body: some View {
        HStack {
            VStack{
                HStack {
                    Text(shop.name)
                        .font(.title.bold())
                        .foregroundColor(Color.white.opacity(0.8))
                    Spacer()
                }
                HStack {
                    Image(systemName: "location.fill")
                    Text(shop.city)
                    Spacer()
                }
                .font(.caption.bold())
                .foregroundColor(Color.gray)
                
            }
            
            Image(shop.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 3.5)
        }
        .frame(width: UIScreen.main.bounds.width - 70)
        
    }
    
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ShopView(shop: shops[0])
        }
    }
}
