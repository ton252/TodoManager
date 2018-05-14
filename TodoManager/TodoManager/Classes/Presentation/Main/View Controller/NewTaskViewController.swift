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
        bindEvents()
    }
    
    
    // MARK: - Bind Events
    
    private func bindEvents() {
        customView.saveButtonHandler = { [unowned self] task in
            self.presentationModel.task = task
            self.presentationModel.saveTask()
            self.dismiss(animated: true)
        }
    }
    
    
    // MARK: - Configure UI
    
    private func configureUI() {
        customView.configure(for: presentationModel.task)
        addCloseButton()
        addRemoveBarButtonItem()
    }
    
    private func addRemoveBarButtonItem() {
        guard !presentationModel.task.isNew else {
            return
        }
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
        presentationModel.eraseTask()
        dismiss(animated: true)
        
    }
    
}
