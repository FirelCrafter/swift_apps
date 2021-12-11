//
//  NewDataView.swift
//  TaskApp
//
//  Created by Михаил Щербаков on 05.10.2021.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.updateItem == nil ? "Add new" : "Update") task")
                    .font(.system(size: 65, weight: .heavy))
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }.padding()
            TextEditor(text: $viewModel.content).padding()
            Divider().padding(.horizontal)
            HStack {
                Text("When")
                    .font(.title.bold())
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }.padding()
            HStack(spacing: 10) {
                DateButton(title: "Today", viewModel: viewModel)
                DateButton(title: "Tomorrow", viewModel: viewModel)
                DatePicker("", selection: $viewModel.date, displayedComponents: .date).labelsHidden()
            }.padding()
            
            // Add button
            
            Button {
                viewModel.writeData(context: context)
            } label: {
                Label(
                    title: {Text(viewModel.updateItem == nil ? "Add" : "Update").font(.title2.bold()).foregroundColor(.white)},
                      icon: {Image(systemName: "plus").font(.title2).foregroundColor(.white)}
                ).padding(.vertical).frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("CreamOrange"), Color("RedPink") ]), startPoint: .leading, endPoint: .trailing)
                    ).cornerRadius(8)
            }.padding()
                .disabled(viewModel.content == "" ? true : false)
                .opacity(viewModel.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}
