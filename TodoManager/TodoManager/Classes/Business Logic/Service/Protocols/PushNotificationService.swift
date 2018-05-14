//
//  PushNotificationService.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


protocol PushNotificationService {
    
    func addPushNotification(for task: Task)
    func removeNotification(for task: Task)
    
}
