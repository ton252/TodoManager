//
//  CoreDataDAO.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//


import Foundation
import CoreData


/// Parent class for `CoreData` translators. 
/// Translators fill properties of new/existant entities from entries and other way.
class CoreDataTranslator<CDModel: NSManagedObject, Model: Entity> {
    
    /// Helper property for `CoreDataDAO`.
    var entryClassName: String {
        return NSStringFromClass(CDModel.self).components(separatedBy: ".").last!
    }
    
    
    /// Creates an instance of class.
    required public init() { }
    
    
    /// All properties of entity will be overridden by entry properties.
    ///
    /// - Parameters:
    ///   - entity: instance of `Model` type.
    ///   - fromEntry: instance of `CDModel` type.
    func fill(_ entity: Model, fromEntry: CDModel) {
        fatalError("Abstact method")
    }
    
    
    /// All properties of entry will be overridden by entity properties.
    ///
    /// - Parameters:
    ///   - entry: instance of `CDModel` type.
    ///   - fromEntity: instance of `Model` type.
    ///   - context: managed object context for current transaction.
    func fill(_ entry: CDModel, fromEntity: Model, in context: NSManagedObjectContext) {
        fatalError("Abstact method")
    }
    
    
    /// All properties of entities will be overridden by entries properties.
    /// For simplicity create new entries w/o changing existent.
    ///
    /// - Parameters:
    ///   - entries: array of instances of `CDModel` type.
    ///   - fromEntities: array of instances of `Model` type.
    ///   - context: managed object context for current transaction.
    func fill(
        _ entries: inout Set<CDModel>,
        fromEntities: [Model],
        in context: NSManagedObjectContext) {
        
        fromEntities
            .compactMap { entity -> (CDModel, Model)? in
                if let entry = NSEntityDescription.insertNewObject(
                        forEntityName: self.entryClassName,
                        into: context) as? CDModel {
                    entries.insert(entry)
                    return (entry, entity)
                } else {
                    return nil
                }
            }
            .forEach {
                self.fill($0.0, fromEntity: $0.1, in: context)
            }
    }
    
    
    /// All properties of entries will be overridden by entities properties.
    ///
    /// - Parameters:
    ///   - entities: array of instances of `CDModel` type.
    ///   - fromEntries: array of instances of `CDModel` type.
    func fill(_ entities: inout [Model], fromEntries: Set<CDModel>?) {
        entities.removeAll()
        
        fromEntries?.forEach {
            let model = Model()
            entities.append(model)
            self.fill(model, fromEntry: $0)
        }
    }
    
}
