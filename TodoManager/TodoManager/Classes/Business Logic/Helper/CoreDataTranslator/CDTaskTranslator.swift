//
//  CDTaskTranslator.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


import CoreData

class CDTaskTranslator: CoreDataTranslator<CDTask, Task> {
    
    override func fill(_ entity: Task, fromEntry: CDTask) {
        entity.entityId = fromEntry.entryId
        entity.title = fromEntry.title
        entity.taskDescription = fromEntry.taskDescription
        entity.date = (fromEntry.date as Date?) ?? Date()
        entity.completed = fromEntry.completed
        entity.reminderTime = fromEntry.reminderTime
    }
    
    required init() {
        super.init()
    }
    
    override func fill(
        _ entry: CDTask,
        fromEntity: Task,
        in context: NSManagedObjectContext) {
        
        entry.entryId = fromEntity.entityId
        entry.title = fromEntity.title
        entry.taskDescription = fromEntity.taskDescription
        entry.date = (fromEntity.date as NSDate?) ?? NSDate()
        entry.completed = fromEntity.completed
        entry.reminderTime = fromEntity.reminderTime
    }
}
