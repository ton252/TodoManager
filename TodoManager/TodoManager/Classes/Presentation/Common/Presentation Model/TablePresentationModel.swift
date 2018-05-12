//
//  TablePresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


/// View model for use in tables
typealias ViewModel = Any


/// View, which can work with View Model
protocol ViewModelConfigurable {
    
    associatedtype ViewModelType: ViewModel
    
    /// Configuring by view model.
    func configure(for viewModel: ViewModelType)
    
    /// Back to default state
    func clear()
    
}

extension ViewModelConfigurable {
    func clear() {
        // do nothing
    }
}



/// Subclass of UITableViewCell with have methods of configuring cell from view model
class ListCell: UITableViewCell, ViewModelConfigurable {
    
    func configure(for viewModel: Any) {
        // abstract
    }
    
    func clear() {
        // abstract
    }
    
}


typealias ActionClosure = (ViewModel) -> Void


/// Protocol for cells with multiple actions
/// To implement an additional actions(in addition to tap on cell itself),
/// you must add a new type of view model. For example, DeleteMessageViewModel.
/// And when you click on the button in cell, call the set actionHandler
/// with this view model.
/// The concrete implementation of the TablePresentationModel in the process (viewModel :) should be able to
/// handle this view model.
/// In our case (DeleteMessageViewModel) - delete the message.
protocol ActionHandler {
    var actionHandler: ActionClosure? { get }
    func set(action: ActionClosure?)
}


/// Type of view model for cell
typealias ViewModelType = ViewModel.Type

/// Type of cell
typealias ListCellType = ListCell.Type

/// Mapper for converting the model type to the cell type
typealias CellMapper = (ViewModelType) -> ListCell.Type



/// Presentation model for working with tabular data representation
class TablePresentationModel: PresentationModel, UITableViewDataSource {
    
    // MARK: Properties
    
    /// Sections of the table
    var viewModels: [ViewModel] = []
    
    /// Mapper for converting the model type to the cell type
    var cellMapper: CellMapper { requiresConcreteImplementation() }

    /// The cell classes for the view model,
    /// which can be found in this Presentation Model
    /// Use to register these classes in the table view
    var possibleCellClasses: [ListCellType] { requiresConcreteImplementation() }
    
    // MARK: PresentationModel
    
    func process(viewModel: ViewModel) {
        requiresConcreteImplementation()
    }
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let viewModelType = type(of: viewModel)
        let cellIdentifier = String(describing: cellMapper(viewModelType.self))
        
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListCell
            else { preconditionFailure() }
        
        if let cell = cell as? ActionHandler {
            cell.set(action: process(viewModel:))
        }
        cell.configure(for: viewModel)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    
    // MARK: Public
    
    /// Handle item selection by index path
    func handleSelection(at indexPath: IndexPath) {
        process(viewModel: viewModels[indexPath.row])
    }
    
}
