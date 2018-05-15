//
//  DetailTaskView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class DetailTaskView: UIView {
    
    private enum Constants {
        static let titleLabel = "Title".localized
        static let dateLabel = "Due time".localized
        static let reminderTimeLabel = "Remind me in".localized
        static let titlePlaceholder = "Enter task name".localized
        static let datePlacholder = "Select task date".localized
        static let timePlaceholder = "Select task reminder time".localized
        static let completedTitle = "Completed".localized
        static let changeButtonTitle = "Change".localized
        static let saveButtonTitle = "Save".localized
    }
    
    
    // MARK: - Handlers
    
    var saveButtonHandler: ((TaskViewModel) -> Void)!
    
    
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
    
    @IBOutlet var titleLabel: UILabel! {
        willSet {
            newValue.text = Constants.titleLabel
        }
    }
    @IBOutlet var dateLabel: UILabel! {
        willSet {
            newValue.text = Constants.dateLabel
        }
    }
    @IBOutlet var reminderTimeLabel: UILabel! {
        willSet {
            newValue.text = Constants.reminderTimeLabel
        }
    }
    
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var titleTextField: UITextField! {
        willSet {
            newValue.addTarget(self, action: #selector(titleChanged(_:)), for: .editingChanged)
            newValue.placeholder = Constants.titlePlaceholder
            newValue.backgroundColor = .clear
            newValue.inputAccessoryView = doneToolBar
        }
    }
    
    @IBOutlet var datePickerContainerView: UIView!
    @IBOutlet var datePickerField: DateFieldView! {
        willSet {
            newValue.backgroundColor = .clear
            newValue.textField.placeholder = Constants.datePlacholder
            newValue.button.setTitle(Constants.changeButtonTitle, for: .normal)
            newValue.picker.datePickerMode = .dateAndTime
            newValue.valueChangedHandler = dateChanged(_:)
        }
    }
    
    @IBOutlet var timePickerContainerView: UIView!
    @IBOutlet var timePickerField: ReminderTimeFieldView! {
        willSet {
            newValue.backgroundColor = .clear
            newValue.textField.placeholder = Constants.timePlaceholder
            newValue.button.setTitle(Constants.changeButtonTitle, for: .normal)
            newValue.valueChangedHandler = timeChanged(_:)
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
            newValue.delegate = self
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
    
    var viewModel: TaskViewModel!
    
    
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
        addKeyboardNotification()
    }
    
    
    // MARK: - IBAction
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveButtonHandler?(viewModel)
    }
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        viewModel.completed = sender.isOn
    }
    
    
    // MARK: - Private Methods
    
    @objc private func doneButtonPressed() {
        endEditing(true)
    }
    
    private func dateChanged(_ date: Date?) -> String? {
        viewModel.date = date
        guard let date = date else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm"
        
        return formatter.string(from: date)
    }
    
    private func timeChanged(_ time: ReminderTime?) -> String? {
        viewModel.reminderTime = time
        guard let time = time else {
            return nil
        }
        return time.formattedString
    }
    
    @objc func titleChanged(_ textField: UITextField) {
        viewModel.title = textField.text
    }
    
    @objc func descriptionChanged(_ textView: UIView) {
        viewModel.description = textView.description
    }
}

extension DetailTaskView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.description = textView.text
    }
    
}


// MARK: ViewModelConfigurable

extension DetailTaskView: ViewModelConfigurable {
    
    func configure(for viewModel: TaskViewModel) {
        self.viewModel = viewModel
        
        titleTextField.text = viewModel.title
        isCompletedSwitcher.isOn = viewModel.completed
        textView.text = viewModel.description
        
        datePickerField.picker.minimumDate = Date()
        datePickerField.value = viewModel.date
        timePickerField.value = viewModel.reminderTime
    }
    
}


// MARK: - Keyboard Notifications

private extension DetailTaskView {
    
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
