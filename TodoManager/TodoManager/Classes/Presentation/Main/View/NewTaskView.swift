//
//  NewTaskView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class NewTaskView: UIView {
    
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var titleTextField: UITextField! {
        willSet {
            newValue.inputAccessoryView = doneToolbar
        }
    }
    
    @IBOutlet var datePickerContainerView: UIView!
    @IBOutlet var datePickerFiled: DatePickerField! {
        willSet {
            newValue.backgroundColor = .clear
        }
    }
    
    @IBOutlet var isComletedContainerView: UIView!
    @IBOutlet var isComletedLabel: UILabel!
    @IBOutlet var isCompletedSwitcher: UISwitch!
    
    @IBOutlet var textView: UITextView! {
        willSet {
            newValue.inputAccessoryView = doneToolbar
        }
    }
    
    private var doneToolbar: UIToolbar {
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: bounds.width, height: 44))
        let flexibleSeparator = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonPressed))
        
        toolbar.items = [flexibleSeparator, doneButton]
        
        return toolbar
    }
    
    @objc func doneButtonPressed() {
        endEditing(true)
    }
    
}


