//
//  UITableView+CellHelper.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


public extension UITableView {
    
    public func register(_ cellClasses: [Swift.AnyClass]) {
        cellClasses.forEach(register(cell:))
    }
    
    public func register(cell cellClass: Swift.AnyClass) {
        let cellId = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: cellId)
    }
    
}
