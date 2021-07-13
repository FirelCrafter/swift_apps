//
//  CartView.swift
//  RubanApp
//
//  Created by Михаил Щербаков on 10/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var viewData: HomeViewModel
    @Environment (\.presentationMode) var present
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button(action: {present.wrappedValue.dismiss()}) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.black)
                }
                
                Text("Корзина")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
                
            }.padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 0) {
                    ForEach(viewData.cartItems) {item in
                        
                        HStack(spacing: 15) {
                            WebImage(url: URL(string: item.item.itemImage))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(item.item.itemName)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(item.item.itemDetails)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 15) {
                                    Text(viewData.getPrice(value: Float(truncating: item.item.itemCost)))
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    Spacer()
                                    
                                    Button(action: {
                                        if item.quantity > 1 {viewData.cartItems[viewData.getIndex(item: item.item, isCartIndex: true)].quantity -= 1}
                                    }) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("\(item.quantity)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .background(Color.black.opacity(0.06))
                                    
                                    Button(action: {
                                        viewData.cartItems[viewData.getIndex(item: item.item, isCartIndex: true)].quantity += 1
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                            }
                            
                        }
                        .padding()
                        .contextMenu {
                            Button(action: {
                                let index = viewData.getIndex(item: item.item, isCartIndex: true)
                                let itemIndex = viewData.getIndex(item: item.item, isCartIndex: false)
                                
                                viewData.items[itemIndex].isAdded = false
                                viewData.filtered[itemIndex].isAdded = false
                                viewData.cartItems.remove(at: index)
                            }, label: {
                                Text("Удалить")
                            })
                        }
                        
                    }
                }
                
            }.padding(.vertical)
            
            VStack {
                HStack {
                    Text("Всего")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(viewData.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                
                Button(action: viewData.updateOrder, label: {
                    Text(viewData.ordered ? "Отменить заказ" : "Заказать")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color.orange, Color.black, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(15)
                })
            }.background(Color.white)
            
        }
        .padding(.vertical, 40)
        .background(Color.white).ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
