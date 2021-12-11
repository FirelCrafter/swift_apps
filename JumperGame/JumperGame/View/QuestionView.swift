//
//  QuestionView.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 31.10.2021.
//

import SwiftUI

struct QuestionView: View {
    
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("OnBoarding")
            Button {
                isPresented.toggle()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(.systemGray4))
                    Text("X")
                        .bold()
                        .foregroundColor(Color.gray)
                    
                }.padding()
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(width: .constant(320), height: .constant(480), isPresented: .constant(true))
    }
}
