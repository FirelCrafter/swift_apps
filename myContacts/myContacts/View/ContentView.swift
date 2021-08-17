//
//  ContentView.swift
//  myContacts
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.contactList) { card in
                    ContactCardView(item: card)
                        .padding(.vertical)
                }
            }.navigationTitle("My Contacts")
        }.alert(item: $viewModel.permissionsError) { _ in
            Alert(title: Text("Permission denied!"), message: Text(viewModel.permissionsError?.description ?? "unknown error"), dismissButton: .default(Text("OK"), action: {viewModel.openSettings()}))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
