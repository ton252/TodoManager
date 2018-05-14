//
//  StorageService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation
import CoreData


protocol StorageService {
    
    func setupDAO<Model, CDModel>(translator: CoreDataTranslator<Model, CDModel>) throws -> CoreDataDAO<Model, CDModel>
    
}
