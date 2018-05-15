//
//  ServiceLayer.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


/// Сlass that stores services and their dependencies
class ServiceLayer {
    
    // MARK: - Shared instance
    
    /// Singleton for accessing services
    static let instance = ServiceLayer()
    
    
    // MARK: - Services
    
    let tasksService: TasksService
    let pushService: PushNotificationService
    
    
    init() {
        tasksService = TasksServiceImpl(storageService: StorageServiceImpl())
        pushService = PushNotificationServiceImpl()
    }
    
}
