//
//  Task.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

final class Task: Entity {
    
    var title: String
    var taskDescription: String
    var date: Date
    var reminderTime: Double
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
        self.reminderTime = .nan
        self.completed = false
        super.init()
    }
    
}
