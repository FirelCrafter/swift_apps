//
//  ItemView.swift
//  DymGet
//
//  Created by Михаил Щербаков on 21.10.2021.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 70)
                .cornerRadius(15)
            HStack {
                
                Text(item.name)
                    
                
                Spacer()
                
                Text("\(item.price) р.")
                
            }
            .padding()
            .font(.title2.bold())
            .foregroundColor(Color.white.opacity(0.8))
            .frame(width: UIScreen.main.bounds.width - 70)
            
            HStack {
                Text(item.description)
                Spacer()
            }
            .padding(.horizontal)
            .font(.title3)
            .foregroundColor(Color.white.opacity(0.8))
            .frame(width: UIScreen.main.bounds.width - 70)
            
            
            Button {
                
            } label: {
                Text("Купить")
                    .font(.title3.bold())
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color("Red"))
                    .cornerRadius(40)
            }
            
        }
    }
    
    
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ItemView(item: shops[0].assort[0])
        }
    }
}
