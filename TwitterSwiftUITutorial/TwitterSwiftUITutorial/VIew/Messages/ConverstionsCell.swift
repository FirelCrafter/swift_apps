//
//  ConverstionsCell.swift
//  TwitterSwiftUITutorial
//
//  Created by Михаил Щербаков on 12/05/2021.
//

import SwiftUI
import Kingfisher

struct ConverstionsCell: View {
    
    let message: Message
    
    var body: some View {
        HStack(spacing: 12) {
            
            //MARK: - Avatar
            
            KFImage.url(URL(string: message.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            //MARK: - Information
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user.fullname)
                    .font(.system(size: 14, weight: .semibold))
                Text(message.text)
                    .font(.system(size: 14))
                    .lineLimit(2)
            }
            .foregroundColor(.black)
            .frame(height: 64)
            .padding(.trailing)
            
            Spacer()
        }
        Divider()
    }
}

//struct ConverstionsCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ConverstionsCell()
//    }
//}
