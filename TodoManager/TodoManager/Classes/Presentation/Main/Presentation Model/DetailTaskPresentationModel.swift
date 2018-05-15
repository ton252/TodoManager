//
//  NewTaskPresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


final class DetailTaskPresentationModel: PresentationModel {
    
    // MARK: - Public Properties
    
    var task: TaskViewModel
    
    
    // MARK: - Private Properties
    
    private let tasksService = ServiceLayer.instance.tasksService
    private let pushService = ServiceLayer.instance.pushService
    
    
    // MARK: - Initializers
    
    init(task: TaskViewModel? = nil, errorHandler: ErrorHandler? = nil) {
        self.task = task ?? DetailTaskPresentationModel.createNewTask()
        super.init(errorHandler: errorHandler)
    }
    
    
    // MARK: - Public Methods
    
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
    
    
    // MARK: - Private Methods
    
    private static func createNewTask() -> TaskViewModel {
        return TaskViewModel(
            entityId: UUID().uuidString,
            title: "",
            description: "Description".localized,
            completed: false)
    }
}
