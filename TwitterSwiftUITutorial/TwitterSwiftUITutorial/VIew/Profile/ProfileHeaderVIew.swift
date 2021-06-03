//
//  ProfileHeaderVIew.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 16/05/2021.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderVIew: View {
    
    @State var selectedFilters: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
//    let user: User
    
    var body: some View {
        VStack {
            KFImage.url(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(120/2)
                .shadow(color: .black, radius: 6, x: 0.0, y: 0.0)
            
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Billionare by day, dark knight by night")
                .font(.system(size: 14))
                .padding(.top, 8)
            
            HStack(spacing: 40) {
                VStack {
                    Text("\(viewModel.user.stats.followers)")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("\(viewModel.user.stats.following)")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            ProfileActionButtonView(viewModel: viewModel)
            
            Spacer()
        }
    }
}

//struct ProfileHeaderVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderVIew()
//    }
//}
