//
//  ConversationsView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 12/05/2021.
//

import SwiftUI

struct ConversationsView: View {
    @State var isSHowNewMessageView = false
    @State var showChat = false
    @State var user: User?
    @State private var inSearchMode = false
    @ObservedObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let user = user {
                NavigationLink(
                    destination: LazyView(ChatView(user: user)),
                    isActive: $showChat,
                    label: {} )
            }
            
            
            ScrollView {
                
                //MARK: - Cells
                
                VStack {
                    ForEach(viewModel.recentMessages){ message in
                            NavigationLink(
                                destination: LazyView(ChatView(user: message.user)),
                                label: {
                                    ConverstionsCell(message: message)
                                })
                    }
                }.padding()
            }
            
            //MARK: - MessageButton
            
            Button(action: {self.isSHowNewMessageView.toggle()}, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $isSHowNewMessageView, content: {
                NewMessageView(show: $isSHowNewMessageView, startChat:$showChat, user: $user)
            })
        }    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
