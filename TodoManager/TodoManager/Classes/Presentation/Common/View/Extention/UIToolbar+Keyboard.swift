//
//  UIToolbar+Keyboard.swift
//  TodoManager
//
//  Created by Anton Polyakov on 13/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


extension UIToolbar {
    
    class func keyboardToolBar(
        style: UIBarButtonSystemItem,
        frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44),
        target: Any?,
        action: Selector?) -> UIToolbar {
        
        let toolbar = UIToolbar(frame: frame)
        let flexibleSeparator = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: style,
            target: target,
            action: action)
        
        toolbar.items = [flexibleSeparator, doneButton]
        
        return toolbar
    }
    
}
