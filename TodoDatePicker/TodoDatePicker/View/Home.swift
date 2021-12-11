//
//  Home.swift
//  TodoDatePicker
//
//  Created by Михаил Щербаков on 30.09.2021.
//

import SwiftUI

//@available(iOS 15.0, *)
struct Home: View {
    
    @State var currentDate: Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                CustomDatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
//        .safeAreaInset(edge: .bottom) {
//            HStack {
//                Button {
//
//                } label: {
//                    Text("Add Task")
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.orange)
//                        .clipShape(Capsule())
//                }
//
//                Button {
//
//                } label: {
//                    Text("Add Reminder")
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.orange)
//                        .clipShape(Capsule())
//                }
//            }
//            .padding(.horizontal)
//            .padding(.top, 10)
//            .background(.white)
//            .background(.ultraThinMaterial)
//        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
