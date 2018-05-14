//
//  MVPMViewController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class MVPMViewController<View: UIView, PM: PresentationModel>: CustomViewController<View> {
    
    
    // MARK: Public Properties
    
    let presentationModel: PM
    
    
    
    // MARK: Initializers
    
    private override init(nibName nibNameOrNil: String?,
                          bundle nibBundleOrNil: Bundle?) {
        preconditionFailure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure()
    }
    
    init(presentationModel: PM) {
        self.presentationModel = presentationModel
        super.init(nibName: nil, bundle: nil)
    }
    
}
