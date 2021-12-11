//
//  StatusBar.swift
//  MedvedVPN (iOS)
//
//  Created by Михаил Щербаков on 13.09.2021.
//

import SwiftUI

struct StatusBar: View {
    var body: some View {
        HStack {
            VStack {
                Text("Download")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                HStack {
                    Image(systemName: "arrow.down.circle")
                    Text("2.4 Mb/s")
                }
            }
            
            Spacer()
            
            VStack {
                Text("Upload")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                HStack {
                    Image(systemName: "arrow.down.circle")
                    Text("2.4 Mb/s")
                }
            }
        }
        .padding(.horizontal, UIScreen.main.bounds.width / 8)
        .foregroundColor(Color("Text"))
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
