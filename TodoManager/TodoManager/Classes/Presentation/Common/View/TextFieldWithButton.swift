//
//  TextFieldWithButton.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class TextFieldWithButton: UIView {
    
    let textField = UITextField()
    let button = UIButton(type: .system)
    
    override var inputView: UIView? {
        set { textField.inputView = newValue }
        get { return textField.inputView }
    }
    
    override var inputAccessoryView: UIView? {
        set { textField.inputAccessoryView = newValue }
        get { return textField.inputAccessoryView }
    }
    
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
        addOpenKeyboardAction()
    }
    
    private func addSubViews() {
        addSubview(textField)
        button.setTitle("Change", for: .normal)
        textField.placeholder = "Select date"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let disableUserIteractionView = UIView()
        disableUserIteractionView.backgroundColor = .clear
        
        addSubview(textField)
        addSubview(disableUserIteractionView)
        addSubview(button)
        
        disableUserIteractionView.fillSuperView()
        
        let textFieldTop = textField.topAnchor.constraint(equalTo: topAnchor)
        let textFieldBottom = textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        let textFieldLeft = textField.leftAnchor.constraint(equalTo: leftAnchor)
        
        let textFieldButtonSpace = button.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 8)
        let buttonRight = button.rightAnchor.constraint(equalTo: rightAnchor)
        let buttonTop = button.topAnchor.constraint(equalTo: topAnchor)
        let buttonBottom = button.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([textFieldTop,
                                     textFieldBottom,
                                     textFieldLeft,
                                     textFieldButtonSpace,
                                     buttonRight,
                                     buttonTop,
                                     buttonBottom])
    }
    
    private func addOpenKeyboardAction() {
        button.addTarget(
            self, action:
            #selector(openKeyboardButtonPressed),
            for: .touchUpInside)
    }

    @objc func openKeyboardButtonPressed() {
        textField.text = nil
        textField.becomeFirstResponder()
    }
    
}
