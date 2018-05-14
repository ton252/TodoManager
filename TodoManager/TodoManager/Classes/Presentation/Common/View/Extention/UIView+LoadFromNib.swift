//
//  UIView+LoadFromNib.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


extension UIView {
    
    class func loadFromNib() -> Self? {
        return viewFromNib(view: self)
    }
    
}


private func viewFromNib<T: UIView>(view: T.Type) -> T? {
    let bundle = Bundle(for: T.self)
    let className = String(describing: T.self)
    
    guard bundle.path(forResource: className, ofType: "nib") != nil
        else { return .none }
    
    guard let nibContent = bundle.loadNibNamed(className, owner: nil)
        else { return .none }
    
    for element in nibContent where element is T {
        if let element = element as? T { return element }
    }
    
    return .none
}
