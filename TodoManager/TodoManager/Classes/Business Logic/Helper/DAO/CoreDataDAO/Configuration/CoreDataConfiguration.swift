//
//  CoreDataConfiguration.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//



import Foundation
import CoreData


/// `CoreData DAO` configuration.
/// Incapsulates basic settings.
/// Used to initialize `CoreData DAO`.
struct CoreDataConfiguration {
    
    /// Name of container also is filename for `*.xcdatamodelid` file.
    let containerName: String
    
    /// Store type like in `CoreData`. `NSInMemoryStoreType`, for instance.
    let storeType: String
    
    /// Options for persistence store
    let options: [String: NSObject]
    
    /// URL of persistent store file
    let persistentStoreURL:URL?
    
    
    /// Create an instance with specified `containerName`, `storeType`, `options`.
    ///
    /// - Parameters:
    ///   - containerName: name. See above.
    ///   - storeType: store type. See above.
    ///   - options: persistence store options.
    ///   - persistentStoreURL: URL of persistent store file.
    init(
        containerName: String,
        storeType: String = NSSQLiteStoreType,
        options: [String : NSObject] =
            [NSMigratePersistentStoresAutomaticallyOption: true as NSObject,
             NSInferMappingModelAutomaticallyOption: true as NSObject],
        persistentStoreURL:URL? = nil) {
        
        self.containerName = containerName
        self.storeType = storeType
        self.options = options
        self.persistentStoreURL = persistentStoreURL
    }
    
}
