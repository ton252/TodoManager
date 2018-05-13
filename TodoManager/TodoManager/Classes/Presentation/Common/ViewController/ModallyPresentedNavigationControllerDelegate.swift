//
//  ModallyPresentedNavigationControllerDelegate.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class BackButtonWithoutTitleNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    open func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
        let backButton = UIBarButtonItem(title: "",
                                         style: UIBarButtonItemStyle.plain,
                                         target: nil,
                                         action: nil)
        
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
}


final class ModallyPresentedNavigationControllerDelegate: BackButtonWithoutTitleNavigationControllerDelegate {
    
    // MARK: - Public Properties
    
    weak var modalNavigationController: UINavigationController?
    
    
    // MARK: - Public Methods
    
    override func navigationController(_ navigationController: UINavigationController,
                                       willShow viewController: UIViewController,
                                       animated: Bool) {
        super.navigationController(navigationController, willShow: viewController, animated: animated)
        
        modalNavigationController = navigationController
        
        if viewController.isRootViewController
            && viewController.navigationItem.leftBarButtonItem == .none {
            setCloseButtonToViewController(viewController)
        }
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func setCloseButtonToViewController(_ viewController: UIViewController) {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop,
                                          target: self,
                                          action: #selector(close))
        
        viewController.navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc fileprivate func close() {
        modalNavigationController?.dismiss(animated: true, completion: .none)
    }
    
}

extension UIViewController {
    var isRootViewController: Bool {
        return self == navigationController?.viewControllers.first
    }
}
