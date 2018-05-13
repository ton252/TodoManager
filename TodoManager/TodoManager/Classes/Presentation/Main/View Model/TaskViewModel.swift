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
    var date: Date
    var completed: Bool = false
    
    var creationDateFromatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm"
        return formatter.string(from: date)
    }
    
}
