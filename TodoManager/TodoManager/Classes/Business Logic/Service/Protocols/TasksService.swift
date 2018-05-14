//
//  TasksService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


protocol TasksService {
    
    func obtainAllTasks() -> [Task]
    func persistTask(_ task: Task)
    
}
