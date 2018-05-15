//
//  StorageService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import CoreData


/// Service to incapsulate working with storage. Implemented to facilitate testing
final class StorageServiceImpl: StorageService {
    
    func setupDAO<Model, CDModel>(translator: CoreDataTranslator<Model, CDModel>) throws
        -> CoreDataDAO<Model, CDModel> {
            let config = CoreDataConfiguration(
                containerName: "TodoManager",
                storeType: NSSQLiteStoreType)
            
            return try CoreDataDAO(translator, configuration: config)
    }
    
}
