//
//  CoreDataDAO.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import CoreData


/// `DAO` pattern implementation for `CoreData`.
class CoreDataDAO<CDModel: NSManagedObject, Model: Entity> : DAO<Model> {

    // MARK: - Private
    
    /// Translator for current `CDModel` and `Model` types.
    private var translator: CoreDataTranslator<CDModel, Model>
    
    
    /// Persistent store cooridnator. Can be configured by `CoreDataConfiguration`.
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator

    
    /// Managed object context. Context is created every transaction due to current queue – 
    /// main or background.
    private var context: NSManagedObjectContext {
         let context = Thread.isMainThread ?
            NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) :
            NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
     
        context.persistentStoreCoordinator = persistentStoreCoordinator
        context.shouldDeleteInaccessibleFaults = true
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }
    
    
    //MARK: - Public
    
    /// Creates an instance with specified `translator` and `configuration`.
    ///
    /// - Parameters:
    ///   - translator: translator for current `CDModel` and `Model` types.
    ///   - configuration: configuration. See also `CoreDataConfiguration`.
    /// - Throws: error if loading or adding persistence store is failed.
    convenience init(_ translator: CoreDataTranslator<CDModel, Model>,
                     configuration: CoreDataConfiguration) throws {
        
        let persistentContainer = NSPersistentContainer(name: configuration.containerName)
        
        persistentContainer.persistentStoreDescriptions
            .forEach { description in
                configuration.options
                    .forEach {
                        description.setOption($0.value, forKey: $0.key)
                }
                description.type = configuration.storeType
                
                if configuration.persistentStoreURL != nil {
                    description.url = configuration.persistentStoreURL
                }
        }
        
        var error: Error?
        
        persistentContainer.loadPersistentStores { _, e in
            error = e
        }
        
        if let error = error { throw error }
        
        self.init(translator, persistentContainer: persistentContainer)
    }
    
    /// Creates an instance with specified `translator` and `persistentContainer`.
    ///
    /// - Parameters:
    ///   - translator: translator for current `CDModel` and `Model` types.
    ///   - persistentContainer: initialized NSPersistentContainer with loaded persistent stores
    convenience init(_ translator: CoreDataTranslator<CDModel, Model>,
                     persistentContainer: NSPersistentContainer) {
        
        self.init(translator,
                  persistentStoreCoordinator: persistentContainer.persistentStoreCoordinator)
    }
    
    /// Creates an instance with specified `translator` and `persistentStoreCoordinator`.
    ///
    /// - Parameters:
    ///   - translator: translator for current `CDModel` and `Model` types.
    ///   - persistentStoreCoordinator: initialized NSPersistentStoreCoordinator with loaded persistent stores
    init(_ translator: CoreDataTranslator<CDModel, Model>,
         persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        
        self.translator = translator
        self.persistentStoreCoordinator = persistentStoreCoordinator
        
        super.init()
    }
    
    
    //MARK: - DAO
    
    override func persist(_ entity: Model) throws {
        var error: Error?
        
        let context = self.context
        
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            
            do {
                if self.isEntryExist(entity.entityId, inContext: context) {
                    try self.update(entity, inContext: context)
                } else {
                    try self.create(entity, inContext: context)
                }
            } catch let e {
                error = e
            }
        }
        
        if let error = error { throw error }
    }
    
    
    override func persist(_ entities: [Model]) throws {
        var error: Error?
        
        let context = self.context
        
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            
            entities.forEach{ entity in
                if self.isEntryExist(entity.entityId, inContext: context) {
                    let existingEntries = self.fetchEntries(entity.entityId, inContext: context)
                    existingEntries.forEach {
                        self.translator.fill($0, fromEntity: entity, in: context)
                    }
                } else if let entry = NSEntityDescription.insertNewObject(
                    forEntityName: self.translator.entryClassName,
                    into: context) as? CDModel {
                    
                    self.translator.fill(entry, fromEntity: entity, in: context)
                }
            }
            
            do {
                try context.save()
            } catch let e {
                error = e
                context.rollback()
            }
        }
        
        if let error = error { throw error }
    }
    
    
    override func read(_ entityId: String) -> Model? {
        guard let entries = try? context.fetch(request(entityId)),
            !entries.isEmpty,
            let entry = entries.first
        else {
            return nil
        }
        
        let entity = Model()
        translator.fill(entity, fromEntry: entry)
        
        return entity
    }
    
    
    override func read() -> [Model] {
        return read(predicatedBy: nil)
    }
    
    
    override func read(predicatedBy predicate: NSPredicate?) -> [Model] {
        return read(predicatedBy: predicate, orderedBy: nil, ascending: false)
    }
    
    
    override func read(
        predicatedBy predicate: NSPredicate?,
        orderedBy field: String?,
        ascending: Bool) -> [Model] {
        
        let sortDescriptors = field != nil ? [NSSortDescriptor(key: field, ascending: ascending)] : []
        
        return fetchEntries(predicate, sortDescriptors: sortDescriptors, inContext: context)
            .compactMap {
                let entity = Model()
                
                self.translator.fill(entity, fromEntry: $0)
                
                return entity
            }
    }
    
    
    override func read(orderedBy field: String?, ascending: Bool) -> [Model] {
        return read(predicatedBy: nil, orderedBy: field, ascending: ascending)
    }

    
    override func erase() throws {
        var error: Error?
        
        let context = self.context
        
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            
            self.fetchEntries(inContext: context)
                .forEach {
                    context.delete($0)
                }
            
            do {
                try context.save()
            } catch let e {
                error = e
                context.rollback()
            }
        }
        
        if let error = error { throw error }
    }
    
    
    override func erase(_ entityId: String) throws {
        var error: Error?
        
        let context = self.context
        
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            
            self.fetchEntries(entityId, inContext: context)
                .forEach {
                    context.delete($0)
                }
            do {
                try context.save()
            } catch let e {
                error = e
                context.rollback()
            }
            
        }
        
        if let error = error { throw error }
    }
    
    
    //MARK: - Private
    
    private func fetchEntries(
            _ entryId: String,
            inContext context: NSManagedObjectContext) -> [CDModel] {
        if let entries = try? context.fetch(request(entryId)) {
            return entries
        } else {
            return [CDModel]()
        }
    }
    
    
    private func fetchEntries(
            _ predicate: NSPredicate? = nil,
            sortDescriptors: [NSSortDescriptor] = [],
            inContext context: NSManagedObjectContext) -> [CDModel] {
        if let entries = try? context.fetch(request(predicate, sortDescriptors: sortDescriptors)) {
            return entries
        } else {
            return [CDModel]()
        }
    }
    
    
    private func request(_ entryId: String) -> NSFetchRequest<CDModel> {
        let request = NSFetchRequest<CDModel>(entityName: translator.entryClassName)
        request.predicate = NSPredicate(format: "entryId == %@", argumentArray: [entryId])
        
        return request
    }

    
    private func request(_ predicate: NSPredicate?,
                         sortDescriptors: [NSSortDescriptor]) -> NSFetchRequest<CDModel> {
        let request = NSFetchRequest<CDModel>(entityName: translator.entryClassName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        return request
    }
    
    
    //MARK: - Transactions
    
    private func isEntryExist(
            _ entryId: String,
            inContext context: NSManagedObjectContext) -> Bool {
        let existingEntries = fetchEntries(entryId, inContext: context)
        return existingEntries.count > 0
    }
    
    
    private func update(_ entity: Model, inContext context: NSManagedObjectContext) throws {
        let existingEntries = fetchEntries(entity.entityId, inContext: context)

        existingEntries.forEach {
            translator.fill($0, fromEntity: entity, in: context)
        }
            
        try context.save()
    }

    
    private func create(_ entity: Model, inContext context: NSManagedObjectContext) throws {
        guard let entry = NSEntityDescription.insertNewObject(
            forEntityName: translator.entryClassName,
            into: context) as? CDModel
        else {
            return
        }
        
        translator.fill(entry, fromEntity: entity, in: context)
        
        try context.save()
    }
    
    
    // MARK: - Helper
    
    private class func url(storeName: String) -> URL {
        var url: URL! = nil
        
        if let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            url = libraryDirectory.appendingPathComponent(storeName)
        }
        
        return url
    }
    
}
