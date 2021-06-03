//
//  UserCell.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 12/05/2021.
//

import SwiftUI
import Kingfisher


//@ObservableObject var viewModel: SearchViewModel

struct UserCell: View {
    
    let user: User
    
    
    var body: some View {
        HStack(spacing: 12) {
            
            //MARK: - Avatar
                
            
            KFImage.url(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            //MARK: - Information
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                Text(user.fullname)
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
        }
    }
}

