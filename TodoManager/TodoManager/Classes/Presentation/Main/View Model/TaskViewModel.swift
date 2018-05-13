//
//  TaskViewModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


struct TaskViewModel: ViewModel {

    var title: String?
    var description: String?
    var completed: Bool = false
    var date: Date?
    var reminderTime: TimeInterval?
    
    let availableReminderTimes: [TimeInterval] =
        [5.0 * 60.0,
         10.0 * 60.0,
         15.0 * 60.0]
    

    var creationDateFromatted: String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm"
        return formatter.string(from: date)
    }
    
    init(title: String?,
         description: String?,
         completed: Bool,
         date: Date? = nil,
         reminderTime: TimeInterval? = nil) {
        self.title = title
        self.description = description
        self.date = date
        self.completed = completed
        self.reminderTime = reminderTime
    }
    
}
