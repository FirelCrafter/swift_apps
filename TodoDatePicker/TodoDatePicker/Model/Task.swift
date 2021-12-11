//
//  Task.swift
//  TodoDatePicker
//
//  Created by Михаил Щербаков on 01.10.2021.
//

import SwiftUI

struct Task: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    
}

struct TaskMetaData: Identifiable {
    
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
    
}

func getSampleData(offset: Int) -> Date {
    
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var TASKS: [TaskMetaData] = [
    
    TaskMetaData(task: [
        Task(title: "Lorem Ipsum"),
        Task(title: "when an unknown"),
        Task(title: "Letraset sheets")
    ], taskDate: getSampleData(offset: 1)),
    
    TaskMetaData(task: [
        Task(title: "opposed to using")
    ], taskDate: getSampleData(offset: -3)),
    
    TaskMetaData(task: [
        Task(title: "There are many variations of passages")
    ], taskDate: getSampleData(offset: -8)),
    
    TaskMetaData(task: [
        Task(title: "Various versions have evolved ")
    ], taskDate: getSampleData(offset: 10))
]
