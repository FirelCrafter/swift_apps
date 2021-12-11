//
//  DateButton.swift
//  TaskApp
//
//  Created by Михаил Щербаков on 05.10.2021.
//

import SwiftUI

struct DateButton: View {
    
    var title: String
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Button {
            viewModel.updateDate(value: title)
        } label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(viewModel.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                
                    LinearGradient(gradient: Gradient(colors: viewModel.checkDate() == title ? [Color("CreamOrange"), Color("RedPink")] : [Color.white]), startPoint: .leading, endPoint: .trailing)
                    
                ).cornerRadius(6)
        }
    }
}

