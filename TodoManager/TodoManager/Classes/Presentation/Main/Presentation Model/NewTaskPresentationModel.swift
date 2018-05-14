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
    
    private static var newTask: TaskViewModel {
        return TaskViewModel(
            title: "",
            description: "No description",
            completed: false)
    }
    
    init(task: TaskViewModel? = nil, errorHandler: ErrorHandler? = nil) {
        self.task = task ?? NewTaskPresentationModel.newTask
        super.init(errorHandler: errorHandler)
    }
    
}
