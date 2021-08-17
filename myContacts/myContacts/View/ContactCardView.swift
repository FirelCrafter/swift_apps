//
//  ContactCardView.swift
//  myContacts
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import SwiftUI

struct ContactCardView: View {
    
    var item: Contact
    @State private var isExpanded = false
    
    
    var body: some View {
        
            VStack(alignment: .leading) {
                
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        VStack {
                            Divider()
                            Button(action: {
                                
                                // Not working on simulator, but working on real device
                                
                                let telString = "tel://"
                                guard let telNum = item.phoneNumber else { return }
                                let formattedString = telString + telNum
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)

                            }, label: {
                                Label(
                                    title: { Text(item.phoneNumber ?? "not provided") },
                                    icon: { Image(systemName: "apps.iphone") }
                                )
                            })
                        }
                        
                    },
                    label: { Button(action: {
                        isExpanded.toggle()
                    }, label: {
                        HStack {
                            Label(
                                title: { Text(item.firstName) },
                                icon: { Image(systemName: "person.crop.circle") }
                            )
                            Text(item.lastName).bold()
                        }
                    }) }
)
                
                
                
            }
            .padding()
            .background(Color.secondary.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .foregroundColor(.black)
        
    }
}


