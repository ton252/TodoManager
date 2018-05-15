//
//  ReminderTimeFieldView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 15/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


final class ReminderTimeFieldView: TextFieldWithButton {
    
    var valueChangedHandler: ((ReminderTime?) -> String?)?
    
    var value: ReminderTime? {
        didSet { textField.text = valueChangedHandler?(value) }
    }
    
    let picker = ReminderTimePicker()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        picker.timeList = [.oneMin, .fiveMin, .oneHour, .oneDay, .oneWeek]
        picker.timeChangedHandler = valueChanged(_:)
        inputView = picker
        inputAccessoryView = UIToolbar
            .keyboardToolBar(leftItemStyle: .stop,
                             rightItemStyle: .done,
                             target: self,
                             leftAction: #selector(clearButtonPressed),
                             rightAction: #selector(doneButtonPressed))
    }
    
    
    // MARK: - Private Method
    
    @objc private func valueChanged(_ picker: ReminderTimePicker) {
        value = picker.time
    }
    
    @objc private func doneButtonPressed() {
        if let picker = textField.inputView as? ReminderTimePicker {
            valueChanged(picker)
        }
        endEditing(true)
    }
    
    @objc private func clearButtonPressed() {
        value = nil
        endEditing(true)
    }
    
}
