//
//  NewTweetView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 16/05/2021.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @Binding var isPresented: Bool
    @State var captionString: String = ""
    @ObservedObject var viewModel: UploadTweetViewModel
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = UploadTweetViewModel(isPresented: isPresented)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    if let user = AuthViewModel.shared.user {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 64, height: 64)
                            .cornerRadius(32)
                    }
                    
                    
                    TextArea("What's happening?", text: $captionString)
                    
                    Spacer()
                }
                .padding()
                .navigationBarItems(leading:
                                        Button(action: {isPresented.toggle()}, label: {
                                            Text("Cancel")
                                                .foregroundColor(.blue)
                                        }),
                                    trailing:
                                        Button(action: {
                                            viewModel.uploadTweet(caption: captionString)
                                        }, label: {
                                            Text("Tweet")
                                                .padding(.horizontal)
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .clipShape(Capsule())
                                    }))
                Spacer()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isPresented: .constant(true))
    }
}
