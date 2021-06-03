//
//  NewMessageView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 13/05/2021.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var user: User?
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)
    
    
    var body: some View {
        ScrollView {
            
            //MARK: - SearchBar

            SearchBar(text: $searchText)
                .padding()
            
            //MARK: - UserCell
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack {Spacer()}
                    
                    Button(action: {
                            self.show.toggle()
                            self.startChat.toggle()
                            self.user = user
                    }, label: {
                        UserCell(user: user)
                    })
                }
            }.padding(.leading)
        }
    }
}

//struct NewMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMessageView(show: .constant(true), startChat: .constant(true))
//    }
//}
