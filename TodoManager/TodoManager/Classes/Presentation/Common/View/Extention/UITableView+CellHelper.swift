//
//  UITableView+CellHelper.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


extension UITableView {
    
    func register(_ cellClasses: [Swift.AnyClass]) {
        cellClasses.forEach(register(cell:))
    }
    
    public func register(cell cellClass: Swift.AnyClass) {
        if let nib = UINib(name: String(describing: cellClass)) {
            register(nib, forCellReuseIdentifier: String(describing: cellClass))
        } else if let nib = UINib(name: NSStringFromClass(cellClass)) {
            register(nib, forCellReuseIdentifier: String(describing: cellClass))
        } else {
            register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
        }
    }
}

extension UINib {
    
    convenience init?(name: String, bundle: Bundle = Bundle.main) {
        guard bundle.path(forResource: name, ofType: "nib") != nil else {
            return nil
        }
        self.init(nibName: name, bundle: bundle)
    }
    
}


