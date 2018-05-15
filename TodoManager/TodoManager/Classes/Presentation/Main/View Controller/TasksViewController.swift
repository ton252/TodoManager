//
//  ViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class TasksViewController: MVPMViewController<CustomTableView, TasksListPresentationModel>, UITableViewDelegate {
    
    var segmentControll: UISegmentedControl!
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTasks()
    }
    
    
    // MARK: - Bind Events
    
    private func bindEvents() {
        presentationModel.updateStateHandler = { [unowned self] state in
            switch state {
            case .rich:
                self.hideZeroView()
            case .zero(let vm):
                self.showZeroView(for: vm)
            case .loading:
                break
            }
            self.reloadData()
        }
    }
    
    private func loadTasks() {
        presentationModel.loadTasks()
    }
    
    private func reloadData() {
        self.customView.tableView.reloadData()
    }
    
    private func filterTasks() {
        presentationModel.filter = filterType(for: segmentControll.selectedSegmentIndex)
        presentationModel.filterTasks()
    }
    
    
    // MARK: - Configure UI
    
    private func configureUI() {
        configureTableView()
        addSegmentControll()
        addAddBarButtonItem()
    }
    
    private func configureTableView() {
        customView.tableView.backgroundColor = .tdBackground
        customView.tableView.delegate = self
        customView.tableView.dataSource = presentationModel
        customView.tableView.register(presentationModel.possibleCellClasses)
    }
    
    private func addSegmentControll() {
        segmentControll = UISegmentedControl(
            items: [segmentItemName(for: .upcomming),
                    segmentItemName(for: .completed)])
        segmentControll.selectedSegmentIndex = presentationModel.filter.rawValue
        segmentControll.sizeToFit()
        navigationItem.titleView = segmentControll
        segmentControll.addTarget(
            self,
            action: #selector(segmentedValueChanged(_:)),
            for: .valueChanged)
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
        filterTasks()
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentationModel.handleSelection(at: indexPath)
    }
    
    
    // MARK: - Helper Methods
    
    private func segmentItemName(for type: TasksListPresentationModel.FilterType) -> String {
        switch type {
        case .upcomming:
            return "Upcomming".localized
        case .completed:
            return "Completed".localized
        }
    }
    
    private func filterType(for index: Int) -> TasksListPresentationModel.FilterType {
        if let type = TasksListPresentationModel.FilterType(rawValue: index) {
            return type
        } else {
            return .upcomming
        }
    }
    
}
