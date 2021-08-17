//
//  ContentItemView.swift
//  myContacts
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import SwiftUI

struct ContentItemView: View {
    
    @ObservedObject var viewModel: ContactsViewModel
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            VStack(alignment: .leading) {
                
            }
        })
    }
}

struct ContentItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContentItemView()
    }
}
