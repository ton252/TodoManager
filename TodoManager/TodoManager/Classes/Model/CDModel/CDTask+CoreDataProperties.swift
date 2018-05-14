//
//  CDTask+CoreDataProperties.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTask {

    @NSManaged public var entryId: String
    @NSManaged public var title: String
    @NSManaged public var taskDescription: String
    @NSManaged public var date: NSDate
    @NSManaged public var reminderTime: Double
    @NSManaged public var completed: Bool

}
