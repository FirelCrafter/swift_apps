//
//  TweetDetailView.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 22/05/2021.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                KFImage.url(URL(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tweet.fullname)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("@\(tweet.username)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Text(tweet.caption)
                .font(.system(size: 22))
            
            
            Text("7:22 PM * 05/01/2020")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Divider()
            
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Retweets")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("\(tweet.likes)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            TweetActionsView(tweet: tweet)
            
            Spacer()
        }.padding()
    }
}

//struct TweetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetDetailView()
//    }
//}
