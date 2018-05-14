//
//  StorageService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation
import CoreData

/// Service to incapsulate working with storage. Implemented to facilitate testing
protocol StorageService {
    
    /// Method for creating DAO
    ///
    /// - Parameter translator: Entity to Entry tanslator
    /// - Returns: Specific CoreDataDAO
    /// - Throws: errors during initialization DAO
    func setupDAO<Model, CDModel>(translator: CoreDataTranslator<Model, CDModel>) throws -> CoreDataDAO<Model, CDModel>
    
}
