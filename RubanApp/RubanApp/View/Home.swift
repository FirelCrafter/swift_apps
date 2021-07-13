//
//  Home.swift
//  RubanApp
//
//  Created by Михаил Щербаков on 10/07/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 15) {
                    
                    Button(action: {
                        withAnimation(.easeIn){viewModel.showMenu.toggle()}
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.orange)
                    })
                    
                    Spacer()
                    
                    Text(viewModel.userLocation == nil ? "Ищем Вас..." : "Доставить: ")
                        .foregroundColor(.black)
                    
                    Text(viewModel.userAdress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                    })

                    TextField("Найти", text: $viewModel.search)
                    
                    
                }.padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                if viewModel.items.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 25) {
                            ForEach(viewModel.filtered) {item in
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                    ItemView(item: item)
                                    
                                    HStack{
                                        
                                        Text("Бесплатная доставка")
                                            .foregroundColor(.white)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal)
                                            .background(Color.orange)
                                        
                                        Spacer(minLength: 0)
                                        
                                        Button(action: {
                                            viewModel.addToCart(item: item)
                                        }, label: {
                                            Image(systemName: item.isAdded ? "checkmark" : "plus")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(item.isAdded ? Color.green : Color.orange)
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.trailing, 10)
                                    .padding(.top, 10)
                                     
                                })
                                .frame(width: UIScreen.main.bounds.width - 30)
                            }
                        }.padding(.top, 10)
                    })
                }
                
            }
            
            HStack {
                SideMenu(viewData: viewModel)
                    .offset(x: viewModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }.background(Color.black.opacity(viewModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                            .onTapGesture(perform: {
                                withAnimation(.easeIn){viewModel.showMenu.toggle()}
                            })
            )
            
            if viewModel.noLocation {
                Text("Пожулуйста, разрешите приложению использовать Вашу геолокацию для определения адреса доставки")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            viewModel.locationManager.delegate = viewModel
        })
        .onChange(of: viewModel.search, perform: { value in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if value == viewModel.search && viewModel.search != "" {
                    viewModel.filterData()
                }
                
            }
            
            if viewModel.search == ""{
                withAnimation(.linear){viewModel.filtered = viewModel.items}
            }
            
        })
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
