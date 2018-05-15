//
//  ApplicationController.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit
import UserNotifications

final class ApplicationController {
    
    static func loadInitialViewController() {
        let vc = MainRouter().initialViewController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
    }
    
    static func notificationRouting(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse) {
        
        guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else {
            return
        }
        
        let taskId = response.notification.request.identifier
        
        guard let task = ServiceLayer.instance.tasksService.obtainTask(by: taskId) else {
            return
        }
        
        let vc = MainRouter().initialViewController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
        
        MainRouter(presenter: vc).presentTask(TaskViewModel(task: task))
    }
    
}
