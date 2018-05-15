//
//  DateFieldView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 15/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


final class DateFieldView: TextFieldWithButton {
    
    var valueChangedHandler: ((Date?) -> String?)?
    
    var value: Date? {
        didSet { textField.text = valueChangedHandler?(value) }
    }
    
    let picker = UIDatePicker()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        picker.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        inputView = picker
        inputAccessoryView = UIToolbar
            .keyboardToolBar(leftItemStyle: .stop,
                             rightItemStyle: .done,
                             target: self,
                             leftAction: #selector(clearButtonPressed),
                             rightAction: #selector(doneButtonPressed))
    }
    
    
    // MARK: - Private Method
    
    @objc private func valueChanged(_ datePicker: UIDatePicker) {
        value = datePicker.date
    }
    
    @objc private func doneButtonPressed() {
        if let datePicker = textField.inputView as? UIDatePicker {
            valueChanged(datePicker)
        }
        endEditing(true)
    }
    
    @objc private func clearButtonPressed() {
        value = nil
        endEditing(true)
    }
    
}
