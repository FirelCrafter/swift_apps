//
//  FeedView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 11/05/2021.
//

import SwiftUI

struct FeedView: View {
    @State var isShowingNewTweetView = false
//    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var viewModel = FeedViewModel()
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                
                //MARK: - Cells
                
                VStack {
                    ForEach(viewModel.tweets){ tweet in
                        NavigationLink(
                            destination: TweetDetailView(tweet: tweet),
                            label: {
                                TweetCell(tweet: tweet)
                            })
                    }
                }.padding()
            }
            
            //MARK: - PlusButton
            
            Button(action: {isShowingNewTweetView.toggle()}, label: {
                Image("Tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
