//
//  Home.swift
//  TaskApp
//
//  Created by Михаил Щербаков on 05.10.2021.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            VStack(spacing: 0) {
                
                HStack {
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }.padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top).background(Color.white)
                
                if results.isEmpty {
                    Spacer()
                    Text("No tasks!")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(results) {task in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(task.content ?? "")
                                        .font(.title.bold())
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                }.foregroundColor(.black)
                                    .contextMenu {
                                        Button {
                                            viewModel.editItem(item: task)
                                        } label: {
                                            Text("Edit")
                                        }
                                        
                                        Button {
                                            context.delete(task)
                                            try! context.save()
                                        } label: {
                                            Text("Delete")
                                        }
                                    }
                            }
                        }.padding()
                    }
                }
                Button {
                    viewModel.isNewData.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(
                            AngularGradient(gradient: Gradient(colors: [Color("CreamOrange"), Color("RedPink")]), center: .center)
                        )
                        .clipShape(Circle())
                }.padding()
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $viewModel.isNewData) {
            NewDataView(viewModel: viewModel)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
