//
//  ServiceLayer.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

class ServiceLayer {
    
    // MARK: Shared instance
    
    static let instance = ServiceLayer()
    
    let tasksService: TasksService
    
    init() {
        tasksService = TasksServiceImpl()
    }
    
}
