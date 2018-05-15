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
    
    class func keyboardToolBar(
        leftItemStyle: UIBarButtonSystemItem,
        rightItemStyle: UIBarButtonSystemItem,
        frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44),
        target: Any?,
        leftAction: Selector?,
        rightAction: Selector?) -> UIToolbar {
        
        let toolbar = UIToolbar(frame: frame)
        let flexibleSeparator = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let leftButton = UIBarButtonItem(
            barButtonSystemItem: leftItemStyle,
            target: target,
            action: leftAction)
        let rightButton = UIBarButtonItem(
            barButtonSystemItem: rightItemStyle,
            target: target,
            action: rightAction)
        
        toolbar.items = [leftButton, flexibleSeparator, rightButton]
        
        return toolbar
    }
    
}
