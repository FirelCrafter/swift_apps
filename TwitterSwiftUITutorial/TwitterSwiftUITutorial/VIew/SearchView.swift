//
//  SearchView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 12/05/2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    
    
    var body: some View {
        ScrollView {
            
            //MARK: - SearchBar

            SearchBar(text: $searchText)
                .padding()
            
            //MARK: - UserCell
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack {Spacer()}
                    
                    NavigationLink(
                        destination: LazyView(UserProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                        })

                }
            }.padding(.leading)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
