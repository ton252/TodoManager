//
//  TaskViewModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


struct TaskViewModel: ViewModel {

    var title: String = ""
    var description: String = ""
    var creationDate: Date
    var completed: Bool = false
    
    var creationDateFromatted: String {
        //TODO: - Append Date Formatter
        return "24.10.2018"
    }
    
}
