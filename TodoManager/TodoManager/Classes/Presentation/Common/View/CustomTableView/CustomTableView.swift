//
//  CustomTableView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class CustomTableView: UIView {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView! {
        willSet { newValue.separatorStyle = .none }
    }
    
}
