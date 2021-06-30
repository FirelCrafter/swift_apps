//
//  SettingsView.swift
//  Present and Dismiss Transition
//
//  Created by Михаил Щербаков on 29/06/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selection: Int = 1
    @State private var setDate = Date()
    @State private var timeZoneOverride = true
    @State private var volume: Double = 25.0
    @Binding  var show: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("Date and time")) {
                        DatePicker(selection: $setDate, label: {
                            Image(systemName: "calendar.circle")
                        }).foregroundColor(.black)
                    }.listRowBackground(Color(UIColor.orange))
                    
                    Section(header: Text("Time Zone Override")) {
                        Toggle(isOn: $timeZoneOverride, label: {
                            HStack {
                                Image(systemName: "timer")
                                Text("Override")
                            }.foregroundColor(.black)
                        })
                    }.listRowBackground(Color(UIColor.orange))
                    
                    Section(header: Text("Alarm Volume")) {
                        Text("Volume \(String(format: "%.0f", volume as Double)) Decibels").foregroundColor(.black)
                        Slider(value: $volume, in: 1...100) { _ in
                            
                        }
                    }.listRowBackground(Color(UIColor.orange))
                    
                    Section(header: Text("Repeat Alarm")) {
                        Picker(selection: $selection, label: Text("Repeat Alarm:")) {
                            Text("No repeat").tag(1)
                            Text("Repeat once").tag(2)
                            Text("Repeat twice").tag(3)
                        }.foregroundColor(.black)
                    }.listRowBackground(Color(UIColor.orange))
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.show = false
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Save")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }.listRowBackground(Color.green)
                }.listStyle(InsetGroupedListStyle())
                
                
            }.frame(width: 350, height: 625)
            .cornerRadius(20)
            
            Text("Settings").offset(y: -250)
                .foregroundColor(.black)
                .font(.title)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(show: .constant(false))
    }
}
