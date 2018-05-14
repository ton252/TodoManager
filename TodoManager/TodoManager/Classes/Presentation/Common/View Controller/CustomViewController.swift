//
//  CustomViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class CustomViewController<View: UIView>: BaseViewController, CustomViewProvider {
    
    typealias ViewType = View
    
    override func loadView() {
        view = ViewType.loadFromNib()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
}
