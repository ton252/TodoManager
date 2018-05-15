//
//  Task.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

/// To do Task entity
final class Task: Entity {
    
    /// Task Title
    var title: String
    
    /// Task Description
    var taskDescription: String
    
    /// Task date
    var date: Date
    
    /// Time, during which it is necessary to remind
    var reminderTime: TimeInterval
    
    /// Task state. true = completed, false = todo
    var completed: Bool
    
    
    init(entityId: String,
         title: String,
         taskDescription: String,
         date: Date,
         reminderTime: Double,
         completed: Bool = false) {
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
        self.reminderTime = reminderTime
        self.completed = completed
        super.init()
        self.entityId = entityId
    }
    
    required init() {
        self.title = ""
        self.taskDescription = ""
        self.date = Date()
        self.reminderTime = 0
        self.completed = false
        super.init()
    }
    
}
