//
//  ViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class TasksViewController: MVPMViewController<CustomTableView, TasksListPresentationModel> {
    
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindEvents()
        loadTasks()
    }
    
    
    // MARK: - Bind Events
    
    private func bindEvents() {
        presentationModel.updateStateHandler = { [unowned self] state in
            switch state {
            case .rich:
                self.customView.tableView.reloadData()
            case .loading:
                break
            case .zero(_):
                break
            }
            
        }
    }
    
    private func loadTasks() {
        presentationModel.loadTasks()
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        configureTableView()
        addSegmentControll()
        addAddBarButtonItem()
    }
    
    private func configureTableView() {
        customView.tableView.backgroundColor = .tdBackground
        customView.tableView.dataSource = presentationModel
        customView.tableView.register(presentationModel.possibleCellClasses)
    }
    
    private func addSegmentControll() {
        let segment: UISegmentedControl = UISegmentedControl(items: ["Upcoming", "Completed"])
        segment.sizeToFit()
        segment.selectedSegmentIndex = 0
        navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func addAddBarButtonItem() {
        let item = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewNoteTap))
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    @objc private func addNewNoteTap() {
        presentationModel.openNewTaskHandler?()
    }
    
    @objc private func segmentedValueChanged(_ segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex)
    }
    
}
