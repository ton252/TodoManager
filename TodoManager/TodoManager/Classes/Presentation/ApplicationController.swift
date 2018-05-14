//
//  ApplicationController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class ApplicationController {
    
    static func loadInitialViewController() {
        let vc = MainRouter().initialViewController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
    }
    
}
