//
//  PushNotificationService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


/// Protocol for working with push notifications
protocol PushNotificationService {
    
    /// Method to add push notification to task
    ///
    /// - Parameter task: Task
    func addPushNotification(for task: Task)
    
    /// Remove pending notification for task
    ///
    /// - Parameter task: Task
    func removeNotification(for task: Task)
    
}
