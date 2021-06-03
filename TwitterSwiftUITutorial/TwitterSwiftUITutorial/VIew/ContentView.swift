//
//  ContentView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 11/05/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View  {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    
                    TabView {
                        FeedView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        
                        ConversationsView()
                            .tabItem {
                                Image(systemName: "envelope")
                                Text("Messages")
                            }
                    }
                    .navigationBarTitle("Home")
                    .navigationBarItems(leading: Button(action:{
                        viewModel.signOut()
                    }, label: {
//                        guard let user1 = viewModel.user else {return}
                        if let user = viewModel.user {
                            KFImage.url(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                        }
                    }))
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
