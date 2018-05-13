//
//  TasksListPresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


final class TasksListPresentationModel: TablePresentationModel {
    
    enum FilterType: Int {
        case upcomming = 0
        case completed = 1
        
        var isCompleted: Bool { return self == .completed }
    }
    
    var filter: FilterType = .upcomming
    var openTaskHandler: ((TaskViewModel) -> Void)?
    var openNewTaskHandler: VoidClosure?
    
    private var tasks = [TaskViewModel]()
    
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
                completed: (i % 2 == 0),
                date: Date())

            tasks.append(task)
        }
        self.tasks = tasks
        viewModels = filter(tasks: tasks, filter: filter)
        state = .rich
    }
    
    func filterTasks() {
        viewModels = filter(tasks: tasks, filter: filter)
        state = .rich
    }
    
    private func filter(tasks: [TaskViewModel], filter: FilterType) -> [TaskViewModel] {
        return tasks.filter { $0.completed == filter.isCompleted }
    }
    
    override func process(viewModel: ViewModel) {
        if let viewModel = viewModel as? TaskViewModel {
            openTaskHandler?(viewModel)
        }
    }
    
}
