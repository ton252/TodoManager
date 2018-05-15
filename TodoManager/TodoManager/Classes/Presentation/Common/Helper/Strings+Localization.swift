//
//  Strings+Localization.swift
//  TodoManager
//
//  Created by Anton Polyakov on 15/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
