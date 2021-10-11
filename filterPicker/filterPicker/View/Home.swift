//
//  Home.swift
//  filterPicker
//
//  Created by Михаил Щербаков on 08.10.2021.
//

import SwiftUI

struct Home: View {
    
    @State var text: String = ""
    @State var tags: [Tag] = []
    
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Filter \nMenus")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(Color("Tag"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TagView(maxLimit: 1500, tags: $tags)
                .frame(height: 280)
                .padding(20)
            
            TextField("apple", text: $text)
                .font(.title3)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color("Tag").opacity(0.4), lineWidth: 1)
                ).environment(\.colorScheme, .dark)
                .padding(.vertical, 15)
            
            Button {
                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 1500) { alert, tag in
                    if alert {
                        showAlert.toggle()
                    } else {
                        tags.append(tag)
                        text = ""
                    }
                }
                
            } label: {
                Text("Add tag")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("BG"))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 45)
                    .background(Color("Tag"))
                    .cornerRadius(12)
            }
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Tag limit"), dismissButton: .destructive(Text("Ok")))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
