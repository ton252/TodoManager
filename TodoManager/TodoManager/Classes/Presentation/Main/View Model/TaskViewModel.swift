//
//  TaskViewModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


struct TaskViewModel: ViewModel {
    
    let entityId: String
    var title: String?
    var description: String?
    var completed: Bool
    var date: Date
    var reminderTime: TimeInterval
    var isNew: Bool

    let availableReminderTimes: [TimeInterval] =
        [5.0 * 60.0,
         10.0 * 60.0,
         15.0 * 60.0]


    var creationDateFromatted: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm"
        return formatter.string(from: date)
    }
    
    init(entityId: String = "",
         title: String? = nil,
         description: String? = nil,
         completed: Bool = false,
         date: Date = Date(),
         reminderTime: TimeInterval = 0,
         isNew: Bool = true) {
        self.entityId = entityId
        self.title = title
        self.description = description
        self.date = date
        self.completed = completed
        self.reminderTime = reminderTime
        self.isNew = isNew
    }
    
}

extension TaskViewModel {
    
    init(task: Task) {
        self.init(
            entityId: task.entityId,
            title: task.title,
            description: task.taskDescription,
            completed: task.completed,
            date: task.date,
            reminderTime: task.reminderTime,
            isNew: false)
    }
    
}

extension Task {
    
    convenience init(viewModel: TaskViewModel) {
        self.init(
            entityId: viewModel.entityId,
            title: viewModel.title.nilIfEmpty ?? "No Title",
            taskDescription: viewModel.description.nilIfEmpty ?? "No description",
            date: viewModel.date,
            reminderTime: viewModel.reminderTime,
            completed: viewModel.completed)
    }
    
}
