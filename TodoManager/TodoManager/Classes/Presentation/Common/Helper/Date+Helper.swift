//
//  Date+Helper.swift
//  TodoManager
//
//  Created by Anton Polyakov on 15/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


// MARK: - Helper Methods

extension Date {
    
    var zeroSeconds: Date {
        let calender = Calendar.current
        let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calender.date(from: dateComponents)!
    }
    
}


// MARK: - Formatted Output

extension Date {
    
    var formattedFull: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM HH:mm:ss"
        return formatter.string(from: self)
    }
    
}
