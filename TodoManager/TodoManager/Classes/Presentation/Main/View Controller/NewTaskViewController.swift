//
//  NewTaskViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class NewTaskViewController: MVPMViewController<NewTaskView, NewTaskPresentationModel> {
    
    private let navCloser = ModallyPresentedNavigationControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Configure UI
    
    private func configureUI() {
        addCloseButton()
        addRemoveBarButtonItem()
    }
    
    private func addRemoveBarButtonItem() {
        let item = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(removeNoteTap))
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    private func addCloseButton() {
        navigationController?.delegate = navCloser
    }
    
    @objc private func removeNoteTap() {
        print("removeNoteTap")
    }
    
}
