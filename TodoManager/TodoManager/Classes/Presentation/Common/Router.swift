//
//  Router.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class Router {
    
    /// View Controller from which to navigate
    /// Optional if the router makes the display over (not push / not modal)
    weak var presenter: UIViewController?
    
    
    /// Router inialization
    ///
    /// - parameter presenter: viewController, that should present
    ///
    /// - returns: router instance
    init(presenter: UIViewController? = nil) {
        self.presenter = presenter
    }
    
    
}


// MARK: - Main methods of display view controller
extension Router {
    
    /// Push naviagation
    ///
    /// - parameter viewController: view controller, which will show
    func show(viewController: UIViewController) {
        guard let presenter = presenter else {
            UIWindow.keyWindowTransit(to: viewController)
            return
        }
        
        presenter.show(viewController, sender: .none)
    }
    
    /// Modal navigation
    ///
    /// - parameter viewController: view controller, which will show
    func presentModally(viewController: UIViewController) {
        guard let presenter = presenter else {
            UIWindow.keyWindowTransit(to: viewController)
            return
        }
        
        presenter.present(viewController,
                          animated: true,
                          completion: .none)
    }
    
    
    /// Dismiss modal view controller
    func dismiss(animated: Bool = true) {
        presenter?.dismiss(
            animated: animated,
            completion: nil)
    }
    
}
