//
//  DatePickerField.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class DatePickerField: UIView {
    
    let label = UILabel()
    let button = UIButton(type: .system)
    private let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubViews()
        addDatePickerInputView()
        addOpenKeyboardAction()
    }
    
    private func addSubViews() {
        addSubview(textField)
        button.setTitle("Change", for: .normal)
        label.text = "Бла бла бла"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(button)
        
        let labelTop = label.topAnchor.constraint(equalTo: topAnchor)
        let labelBottom = label.bottomAnchor.constraint(equalTo: bottomAnchor)
        let labelLeft = label.leftAnchor.constraint(equalTo: leftAnchor)
        
        let labelButtonSpace = label.rightAnchor.constraint(equalTo: button.leftAnchor, constant: 8)
        let buttonRight = button.rightAnchor.constraint(equalTo: rightAnchor)
        let buttonTop = button.topAnchor.constraint(equalTo: topAnchor)
        let buttonBottom = button.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([labelTop,
                                     labelBottom,
                                     labelLeft,
                                     labelButtonSpace,
                                     buttonRight,
                                     buttonTop,
                                     buttonBottom])
    }
    
    private func addOpenKeyboardAction() {
        button.addTarget(self, action: #selector(openKeyboardButtonPressed), for: .touchUpInside)
    }
    
    private func addDatePickerInputView() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        textField.inputView = datePicker
        
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
        textField.inputAccessoryView = toolbar
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        label.text = formatter.string(from: datePicker.date)
    }
    
    @objc func doneButtonPressed() {
        textField.endEditing(true)
    }
    
    @objc func openKeyboardButtonPressed() {
        textField.becomeFirstResponder()
    }
    
}
