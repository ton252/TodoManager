//
//  TasksListPresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


final class TasksListPresentationModel: TablePresentationModel {
    
    // MARK: - Handlers
    
    var openTaskHandler: ((TaskViewModel) -> Void)?
    var openNewTaskHandler: VoidClosure?
    
    
    // MARK: - Public Properties
    
    enum FilterType: Int {
        case upcomming = 0
        case completed = 1
        
        var isCompleted: Bool { return self == .completed }
    }
    
    var filter: FilterType = .upcomming
    
    
    // MARK: - Private Propeties
    
    private let tasksService = ServiceLayer.instance.tasksService
    
    private var tasks = [TaskViewModel]()
    
    
    // MARK: - Public Methods
    
    func loadTasks() {
        tasks = tasksService
            .obtainAllTasks()
            .compactMap { TaskViewModel(task: $0) }
            .reversed()
        viewModels = filter(tasks: tasks, filter: filter)
        state = .rich
    }
    
    func filterTasks() {
        viewModels = filter(tasks: tasks, filter: filter)
        state = .rich
    }
    
    
    // MARK: - Private Methods
    
    private func filter(tasks: [TaskViewModel], filter: FilterType) -> [TaskViewModel] {
        return tasks.filter { $0.completed == filter.isCompleted }
    }
    
    
    // MARK: - Table DataSource
    
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
    
    override func process(viewModel: ViewModel) {
        if let viewModel = viewModel as? TaskViewModel {
            DispatchQueue.main.async { [unowned self] in
                self.openTaskHandler?(viewModel)
            }
        }
    }
    
}
