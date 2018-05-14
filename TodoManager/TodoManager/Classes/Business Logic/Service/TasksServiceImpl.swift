//
//  TasksServiceImpl.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

final class TasksServiceImpl: TasksService {
    
    private let config = CoreDataConfiguration(containerName: "TodoManager")
    

    func obtainAllTasks() -> [Task] {
        guard let dao = try? CoreDataDAO(CDTaskTranslator(), configuration: config) else {
            return []
        }
        return dao.read()
    }
    
    func persistTask(_ task: Task) {
        guard let dao = try? CoreDataDAO(CDTaskTranslator(), configuration: config) else {
            return
        }
        try? dao.persist(task)
    }
    
}
