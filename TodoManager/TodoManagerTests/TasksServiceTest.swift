//
//  TasksServiceTest.swift
//  TodoManagerTests
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import XCTest
import CoreData
@testable import TodoManager


private final class StorageServiceMock: StorageService {
    
    private var testStoreURL: URL {
        let storeDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return storeDirectory.appendingPathComponent("TestStore.sqlite")
    }
    
    func setupDAO<Model, CDModel>(translator: CoreDataTranslator<Model, CDModel>) throws
        -> CoreDataDAO<Model, CDModel> {

            let config = CoreDataConfiguration(
                containerName: "TodoManager",
                storeType: NSSQLiteStoreType,
                persistentStoreURL: testStoreURL)
            
            return try CoreDataDAO(translator, configuration: config)
    }
    
    func erase() {
        try? NSPersistentStoreCoordinator()
            .destroyPersistentStore(
                at: testStoreURL,
                ofType: NSSQLiteStoreType,
                options: nil)
    }
    
}


final class TasksServiceTest: XCTestCase {
    
    private var tasksService: TasksService!
    private var storageService: StorageServiceMock!
    
    private var defaultTasks: [Task] {
        var tasks = [Task]()
        for i in 0..<5 {
            let task = Task(
                entityId: "\(i)",
                title: "Title \(i)",
                taskDescription: "Description \(i)",
                date: Date(),
                reminderTime: 0)
            tasks.append(task)
        }
        return tasks
    }
    
    override func setUp() {
        super.setUp()
        storageService = StorageServiceMock()
        tasksService = TasksServiceImpl(storageService: storageService)
    }
    
    override func tearDown() {
        super.tearDown()
        storageService.erase()
    }
    
    func testPersistTask() {
        tasksService.persistTask(defaultTasks[0])
        let tasks = tasksService.obtainAllTasks()
        XCTAssert(tasks.count == 1, "PersistTask failed: Wrong number of objects in storage")
    }
    
    func testObtainAllTasks() {
        defaultTasks.forEach { tasksService.persistTask($0) }
        let tasks = tasksService.obtainAllTasks()
        XCTAssert(tasks.count == defaultTasks.count, "ObtainAllTasks failed: Wrong number of objects in storage")
    }
    

    func testEraseTask() {
        tasksService.persistTask(defaultTasks[0])
        tasksService.eraseTask(by: defaultTasks[0].entityId)
        let tasks = tasksService.obtainAllTasks()
        XCTAssert(tasks.count == 0, "EraseTask failed: number of objects in storage")
    }

}
