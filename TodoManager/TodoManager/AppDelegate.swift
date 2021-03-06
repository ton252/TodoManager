//
//  AppDelegate.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        ApplicationController.loadInitialViewController()
        window?.makeKeyAndVisible()
        
        ServiceLayer.instance.pushService.notificationResponse =
            ApplicationController.notificationRouting(_:didReceive:)
        
        return true
    }

}
