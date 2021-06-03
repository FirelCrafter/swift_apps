//
//  MessageInputView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 13/05/2021.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var messageText: String
    
    
    var action: () -> Void
    
    
    var body: some View {
        HStack {
            TextField("Message...", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(minHeight: 30)
            
            Button(action: action, label: {
                Text("Send")
            })
        }
    }
}
