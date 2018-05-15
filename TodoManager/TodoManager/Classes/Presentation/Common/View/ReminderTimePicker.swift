//
//  ReminderTime.swift
//  TodoManager
//
//  Created by Anton Polyakov on 13/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


enum ReminderTime: TimeInterval {
    case oneMin = 60 // 1 * 60
    case fiveMin = 300 // 5 * 60
    case oneHour = 3600 // 1 * 60 * 60
    case oneDay = 86400 // 1 * 24 * 60 * 60
    case oneWeek = 604800 // 7 * 24 * 60 * 60
    
    var formattedString: String {
        switch self {
        case .oneMin:
            return "1 min".localized
        case .fiveMin:
            return "5 min".localized
        case .oneHour:
            return "1 hour".localized
        case .oneDay:
            return "1 day".localized
        case .oneWeek:
            return "1 week".localized
        }
    }
}


class ReminderTimePicker: UIPickerView {
    
    var timeChangedHandler: ((ReminderTimePicker) -> Void)?
    
    var timeList = [ReminderTime]() {
        didSet {
            time = timeList.count > 0 ? timeList[0] : .oneMin
            reloadAllComponents()
        }
    }
    
    var time: ReminderTime = .oneMin {
        didSet {
            guard let row = timeList.index(of: time) else { return }
            selectRow(row, inComponent: 0, animated: true)
        }
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
        delegate = self
        dataSource = self
    }
    
}


// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension ReminderTimePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeList[row].formattedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let pickerView = pickerView as? ReminderTimePicker else { return }
        time = timeList[row]
        timeChangedHandler?(pickerView)
    }
}
