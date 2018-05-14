//
//  TasksService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


/// Service for woring with tasks
protocol TasksService {
    
    /// Obtain all task from storage
    ///
    /// - Returns: Array of Task
    func obtainAllTasks() -> [Task]
    

    /// Persist task to storage
    ///
    /// - Parameter task: Task to persist
    func persistTask(_ task: Task)
    

    /// Erase task from storage
    ///
    /// - Parameter taskId: Task identifier
    func eraseTask(by taskId: String)
    
}
