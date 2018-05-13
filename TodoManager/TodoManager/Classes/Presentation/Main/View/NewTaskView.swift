//
//  NewTaskView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class NewTaskView: UIView {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var titleTextField: UITextField! {
        willSet {
            newValue.backgroundColor = .clear
            newValue.inputAccessoryView = doneToolBar
        }
    }
    
    @IBOutlet var datePickerContainerView: UIView!
    @IBOutlet var datePickerField: TextFieldWithButton! {
        willSet {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.minimumDate = Date()
            datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            newValue.inputView = datePicker
            
            newValue.inputAccessoryView = UIToolbar.keyboardToolBar(
                style: .done,
                target: self,
                action: #selector(dateDoneButtonPressed))
            
            newValue.backgroundColor = .clear
        }
    }
    
    @IBOutlet var timePickerContainerView: UIView!
    @IBOutlet var timePickerField: TextFieldWithButton! {
        willSet {
            let timePicker = TimePicker()
            timePicker.timeList = [5.0 * 60.0, 10.0 * 60.0, 15.0 * 60.0]
            timePicker.timeChangedHandler = timeChanged(_:)
            newValue.inputView = timePicker
            
            newValue.inputAccessoryView = UIToolbar.keyboardToolBar(
                style: .done,
                target: self,
                action: #selector(timeDoneButtonPressed))
            
            newValue.backgroundColor = .clear
        }
    }
    
    @IBOutlet var isComletedContainerView: UIView!
    @IBOutlet var isComletedLabel: UILabel!
    @IBOutlet var isCompletedSwitcher: UISwitch!
    
    @IBOutlet var textContainerView: UIView!
    @IBOutlet var textView: UITextView! {
        willSet {
            newValue.backgroundColor = .clear
            newValue.inputAccessoryView = doneToolBar
        }
    }
    
    @IBOutlet var buttonContainerView: UIView! {
        willSet {
            newValue.backgroundColor = .clear
        }
    }
    @IBOutlet var saveButton: UIButton! {
        willSet {
            newValue.layer.masksToBounds = true
            newValue.layer.cornerRadius = 8
            newValue.backgroundColor = .tdTint
        }
    }
    
    
    // MARK: - Public Properties
    
    var selectedDate: Date = Date()
    var selectedTime: TimeInterval = 0
    
    
    // MARK: - Private Properties
    
    private var doneToolBar: UIToolbar {
        return UIToolbar.keyboardToolBar(
            style: .done,
            target: self,
            action: #selector(doneButtonPressed))
    }
    
    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .tdBackground
    }
    
    
    // MARK: - Private Methods
    
    @objc private func doneButtonPressed() {
        endEditing(true)
    }
    
    @objc private func dateDoneButtonPressed() {
        if let datePicker = datePickerField.inputView as? UIDatePicker {
            dateChanged(datePicker)
        }
        endEditing(true)
    }
    
    @objc private func timeDoneButtonPressed() {
        if let timePicker = timePickerField.inputView as? TimePicker {
            timeChanged(timePicker)
        }
        endEditing(true)
    }
    
    @objc private func dateChanged(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm"
        selectedDate = datePicker.date
        datePickerField.textField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func timeChanged(_ timePicker: TimePicker) {
        selectedTime = timePicker.time
        timePickerField.textField.text = timePicker.formattedTime
    }
    
}
