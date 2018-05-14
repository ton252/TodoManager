//
//  NewTaskPresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


final class NewTaskPresentationModel: PresentationModel {
    
    var task: TaskViewModel
    
    private let tasksService = ServiceLayer.instance.tasksService
    
    init(task: TaskViewModel? = nil, errorHandler: ErrorHandler? = nil) {
        self.task = task ?? NewTaskPresentationModel.createNewTask()
        super.init(errorHandler: errorHandler)
    }
    
    func saveTask() {
        let entityId = task.entityId
        let title = task.title.nilIfEmpty ?? "No Title"
        let description = task.description.nilIfEmpty ?? "No description"
        let reminderTime = task.reminderTime
        let date = task.date
        let completed = task.completed

        let taskModel =
            Task(entityId: entityId,
                 title: title,
                 taskDescription: description,
                 date: date,
                 reminderTime: reminderTime,
                 completed: completed)

        tasksService.persistTask(taskModel)
    }
    
    func eraseTask() {
        tasksService.eraseTask(by: task.entityId)
    }
    
    private static func createNewTask() -> TaskViewModel {
        return TaskViewModel(
            entityId: UUID().uuidString,
            title: "",
            description: "No description",
            completed: false)
    }
}
