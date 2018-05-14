//
//  CustomViewProvider.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

/// The protocol says that the View Controller loads the overridden View from the XIB file
protocol CustomViewProvider {
    associatedtype ViewType
}

extension CustomViewProvider where Self: UIViewController, Self.ViewType: UIView {
    
    /// Typed View
    var customView: Self.ViewType {
        get {
            guard let view = view as? Self.ViewType else {
                fatalError("Couldn't cast view to ViewType")
            }
            return view
        }
        set {
            view = newValue
        }
    }
    
}
