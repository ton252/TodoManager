//
//  BaseViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// MARK: - Public Propeties
    
    lazy var zeroView: ZeroView = ZeroView.loadFromNib()!

    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Public Methods
    
    func showZeroView(for viewModel: ZeroViewModel) {
        zeroView.configure(for: viewModel)
        view.addSubview(zeroView)
        zeroView.fillSuperView()
    }
    
    func hideZeroView() {
        zeroView.removeFromSuperview()
    }

}
