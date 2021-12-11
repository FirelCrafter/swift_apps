//
//  NavigationBarView.swift
//  OctaShop
//
//  Created by Михаил Щербаков on 01.10.2021.
//

import SwiftUI

struct NavigationBarView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var webTitle = ""
    
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: 10) {
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.backward)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.forward)
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 30, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
                Text(webTitle).onReceive(self.viewModel.webTitle.receive(on: RunLoop.main)) { value in
                                    self.webTitle = value
                                }
                Spacer()
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.reload)
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 30, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
            }
            .frame(height: 50)
            Divider()
        }.padding(.horizontal)
    }
    
}


