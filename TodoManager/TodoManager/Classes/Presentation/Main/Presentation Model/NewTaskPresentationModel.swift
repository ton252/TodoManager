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
    private let pushService = ServiceLayer.instance.pushService
    
    init(task: TaskViewModel? = nil, errorHandler: ErrorHandler? = nil) {
        self.task = task ?? NewTaskPresentationModel.createNewTask()
        super.init(errorHandler: errorHandler)
    }
    
    func saveTask() {
        tasksService.persistTask(Task(viewModel: task))
    }
    
    func addPushNotification() {
        guard !task.completed else { return }
        pushService.addPushNotification(for: Task(viewModel: task))
    }
    
    func removePushNotification() {
        pushService.removeNotification(for: Task(viewModel: task))
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
