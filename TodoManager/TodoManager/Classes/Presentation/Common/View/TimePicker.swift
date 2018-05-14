//
//  TimePicker.swift
//  TodoManager
//
//  Created by Anton Polyakov on 13/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class TimePicker: UIPickerView {
    
    var timeChangedHandler: ((TimePicker) -> Void)?
    
    var timeList = [TimeInterval]() {
        didSet {
            if timeList.count > 0 { time = timeList[0] }
            reloadAllComponents()
        }
    }
    
    var time: TimeInterval = 0 {
        didSet { formattedTime = formatTime(time) }
    }
    private(set) var formattedTime: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
        dataSource = self
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        return "\(Int(time / 60)) min"
    }
}


// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension TimePicker: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formatTime(timeList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let pickerView = pickerView as? TimePicker else { return }
        time = timeList[row]
        timeChangedHandler?(pickerView)
    }
}
