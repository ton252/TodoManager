//
//  WindowHelper.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


extension UIWindow {
    
    class func keyWindowTransit(to viewController: UIViewController, animated: Bool = true) {
        if let window = UIApplication.shared.keyWindow {
            window.transit(to: viewController, animated: animated)
        } else if let window = UIApplication.shared.delegate?.window {
            window?.transit(to: viewController, animated: animated)
        }
    }
    
    func transit(to viewController: UIViewController, animated: Bool = true) {
        guard animated else {
            self.rootViewController = viewController
            return
        }
        
        let currentSubviews = subviews
        insertSubview(viewController.view, belowSubview: rootViewController!.view)
        
        UIView.transition(
            with: self,
            duration: 0.4,
            options: .transitionCrossDissolve,
            animations: { self.rootViewController = viewController },
            completion: { _ in
                currentSubviews.forEach({ $0.removeFromSuperview() })
        })
    }
    
}
