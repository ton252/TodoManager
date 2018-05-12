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
        let vc = TasksViewController()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
    
}
