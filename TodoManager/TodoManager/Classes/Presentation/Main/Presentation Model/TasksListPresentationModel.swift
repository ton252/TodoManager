//
//  TasksListPresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


final class TasksListPresentationModel: TablePresentationModel {
    
    override var possibleCellClasses: [ListCellType] {
        let viewModelTypes: [ViewModel.Type] = [TaskViewModel.self]
        return viewModelTypes.map(cellMapper)
    }
    
    override var cellMapper: CellMapper {
        return { (viewModelType: ViewModel.Type) -> ListCell.Type in
            switch viewModelType {
            case is TaskViewModel.Type:
                return ContainerCell<TaskCellView>.self
            default:
                preconditionFailure()
            }
        }
    }
    
    func loadTasks() {
        // TODO: - Replace with loading from storage
        var tasks = [TaskViewModel]()
        for i in 0..<100 {
            let title = "Title \(i)"
            let description = "Description \(i)\nDescription \(i)\nDescription \(i)"
            let task = TaskViewModel(
                title: title,
                description: description,
                creationDate: Date(),
                completed: (i % 2 == 0))

            tasks.append(task)
        }
        viewModels = tasks
        state = .rich
    }
    
}
