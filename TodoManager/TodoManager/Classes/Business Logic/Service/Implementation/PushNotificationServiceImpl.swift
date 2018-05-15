//
//  PushNotificationServiceImpl.swift
//  TodoManager
//
//  Created by Anton Polyakov on 14/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit
import UserNotifications

/// Service for working with push notifications
final class PushNotificationServiceImpl: NSObject, PushNotificationService {
    
    
    // MARK: - Private Properties
    
    /// Notification Authorization Options
    private let options: UNAuthorizationOptions = [.alert, .badge, .sound]
    
    /// Singleton Notification Center
    private let notificationCenter = UNUserNotificationCenter.current()
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        registerCenter()
    }
    
    
    // MARK: - Public Methods
    
    func addPushNotification(for task: Task) {
        let notificationDate = task.date.addingTimeInterval(-task.reminderTime)
        
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: notificationDate)
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerDate,
            repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.body = task.taskDescription
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: task.entityId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func removeNotification(for task: Task) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [task.entityId])
    }
    
    
    // MARK: - Private Methods
    
    private func registerCenter() {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: options, completionHandler: { _, _ in })
        UIApplication.shared.registerForRemoteNotifications()
    }
    
}


// MARK: - UNUserNotificationCenterDelegate

extension PushNotificationServiceImpl: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}