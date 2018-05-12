//
//  ViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class TasksViewController: CustomViewController<CustomTableView> {
    
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Configure UI
    
    private func configureUI() {
        addSegmentControll()
        addAddBarButtonItem()
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
        print("addNewNoteTap")
    }
    
    @objc private func segmentedValueChanged(_ segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex)
    }
    
}
