//
//  LayoutHelper.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperView() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = superview.topAnchor.constraint(equalTo: self.topAnchor)
        let bottom = superview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let left = superview.leftAnchor.constraint(equalTo: self.leftAnchor)
        let right = superview.rightAnchor.constraint(equalTo: self.rightAnchor)
        NSLayoutConstraint.activate([top, bottom, left, right])
    }
    
}
