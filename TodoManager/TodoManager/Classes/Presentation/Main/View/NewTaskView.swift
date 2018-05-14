//
//  NewTaskView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class NewTaskView: UIView {
    
    private enum Constants {
        static let titlePlaceholder = "Enter task name"
        static let datePlacholder = "Select task date"
        static let timePlaceholder = "Select task reminder time"
        static let completedTitle = "Completed"
        static let changeButtonTitle = "Change"
        static let saveButtonTitle = "Save"
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var scrollView: UIScrollView! {
        willSet {
            backgroundColor = .tdBackground
        }
    }
    @IBOutlet var contentView: UIView! {
        willSet {
            newValue.backgroundColor = .clear
        }
    }
    
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var titleTextField: UITextField! {
        willSet {
            newValue.placeholder = Constants.titlePlaceholder
            newValue.backgroundColor = .clear
            newValue.inputAccessoryView = doneToolBar
        }
    }
    
    @IBOutlet var datePickerContainerView: UIView!
    @IBOutlet var datePickerField: TextFieldWithButton! {
        willSet {
            newValue.textField.placeholder = Constants.datePlacholder
            newValue.button.setTitle(Constants.changeButtonTitle, for: .normal)
            
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
            newValue.textField.placeholder = Constants.timePlaceholder
            newValue.button.setTitle(Constants.changeButtonTitle, for: .normal)
            
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
    @IBOutlet var isCompletedSwitcher: UISwitch!
    @IBOutlet var isComletedLabel: UILabel! {
        willSet {
            newValue.text = Constants.completedTitle
        }
    }
    
    @IBOutlet var textContainerView: UIView!
    @IBOutlet var textView: UITextView! {
        willSet {
            newValue.text = nil
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
            newValue.setTitle(Constants.saveButtonTitle, for: .normal)
            
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
    
    private let timePicker = TimePicker()
    private let datePicker = UIDatePicker()
    
    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addKeyboardNotification()
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


// MARK: ViewModelConfigurable

extension NewTaskView: ViewModelConfigurable {
    
    func configure(for viewModel: TaskViewModel) {
        titleTextField.text = viewModel.title
        isCompletedSwitcher.isOn = viewModel.completed
        textView.text = viewModel.description
        
        if let date = viewModel.date {
            datePicker.date = date
            dateChanged(datePicker)
        } else {
            datePickerField.textField.text = nil
        }
        
        if let time = viewModel.reminderTime {
            timePicker.time = time
            timeChanged(timePicker)
        } else {
            timePickerField.textField.text = nil
        }
        
        timePicker.timeList = viewModel.availableReminderTimes
    }
    
}


// MARK: - Keyboard Notifications

private extension NewTaskView {
    
    func addKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: .UIKeyboardWillHide,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: .UIKeyboardWillChangeFrame,
                                       object: nil)

    }
    
    @objc func adjustForKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return
        }
        
        guard let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        
        if notification.name == .UIKeyboardWillHide {
            scrollView.contentInset.bottom = 0
            scrollView.scrollIndicatorInsets.bottom = 0
        } else {
            let inputAccessoryViewHeight: CGFloat = 44.0
            let inset = keyboardEndFrame.height - inputAccessoryViewHeight
            scrollView.contentInset.bottom = inset
            scrollView.scrollIndicatorInsets.bottom = inset
        }
    }
    
}
