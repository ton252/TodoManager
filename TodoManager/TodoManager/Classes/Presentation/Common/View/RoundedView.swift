//
//  RoundedView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 13/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


@IBDesignable
final class RoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .tdElement
    }
    
    
}
