//
//  AppDelegate.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)

        application.registerUserNotificationSettings(pushNotificationSettings)
            application.registerForRemoteNotifications()
        let navC = UINavigationController(rootViewController: ViewController.sharedInstance)
        ViewController.sharedInstance.title = "我的google表單"
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var tokenString = ""
       for byte in deviceToken {
          let hexString = String(format: "%02x", byte)
          tokenString += hexString
       }
        print("tokenString = \(tokenString)")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("register notification error:\(error.localizedDescription)")
    }


}

