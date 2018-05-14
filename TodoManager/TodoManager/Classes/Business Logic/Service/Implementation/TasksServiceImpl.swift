//
//  TasksServiceImpl.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

final class TasksServiceImpl: TasksService {
    
    private let storageService: StorageService
    
    
    init(storageService: StorageService) {
        self.storageService = storageService
    }

    func obtainAllTasks() -> [Task] {
        guard let dao = try? storageService.setupDAO(translator: CDTaskTranslator()) else {
            return []
        }
        return dao.read()
    }
    
    func persistTask(_ task: Task) {
        guard let dao = try? storageService.setupDAO(translator: CDTaskTranslator()) else {
            return
        }
        try? dao.persist(task)
    }
    
    func eraseTask(by taskId: String) {
        guard let dao = try? storageService.setupDAO(translator: CDTaskTranslator()) else {
            return
        }
        try? dao.erase(taskId)
    }
    
}
