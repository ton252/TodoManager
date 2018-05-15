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
    
    var zeroUpcommingTasks: ZeroViewModel {
        return ZeroViewModel(
            info: "The task list is empty. Click \"+ \"\n to add a new task".localized)
    }
    var zeroCompletedTasks: ZeroViewModel {
        return ZeroViewModel(
            info: "You have no completed tasks.\n Create and complete a task to see it in the list".localized)
    }

    
    // MARK: - Public Methods
    
    func loadTasks() {
        tasks = tasksService
            .obtainAllTasks()
            .compactMap { TaskViewModel(task: $0) }
            .reversed()
        viewModels = filter(tasks: tasks, filter: filter)
        configureState()
    }
    
    func filterTasks() {
        viewModels = filter(tasks: tasks, filter: filter)
        configureState()
    }
    
    
    // MARK: - Private Methods
    
    private func filter(tasks: [TaskViewModel], filter: FilterType) -> [TaskViewModel] {
        return tasks.filter { $0.completed == filter.isCompleted }
    }
    
    private func configureState() {
        guard viewModels.count == 0 else {
            state = .rich
            return
        }
        switch filter {
        case .upcomming:
            state = .zero(zeroUpcommingTasks)
        case .completed:
            state = .zero(zeroCompletedTasks)
        }
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
