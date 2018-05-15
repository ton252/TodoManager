//
//  MainRouter.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class MainRouter: Router {
    
    
    // MARK: - Public Methods
    
    func initialViewController() -> UINavigationController {
        let pm = TasksListPresentationModel()
        let vc = TasksViewController(presentationModel: pm)
        let nc = UINavigationController(rootViewController: vc)
        
        let baseRouter = MainRouter(presenter: vc)
        pm.openNewTaskHandler = baseRouter.presentNewTask
        pm.openTaskHandler = baseRouter.presentTask(_:)
        
        return nc
    }
    
    func presentTask(_ task: TaskViewModel) {
        let pm = DetailTaskPresentationModel(task: task)
        let vc = DetailTaskViewController(presentationModel: pm)
        let nc = UINavigationController(rootViewController: vc)
        
        presentModally(viewController: nc)
    }
    
    func presentNewTask() {
        let pm = DetailTaskPresentationModel()
        let vc = DetailTaskViewController(presentationModel: pm)
        let nc = UINavigationController(rootViewController: vc)
        
        presentModally(viewController: nc)
    }
    
}
