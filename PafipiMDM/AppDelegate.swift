//
//  AppDelegate.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 07/03/2021.
//

import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let applicationBootloader = ApplicationBootloaderImpl()
    private let rootCoordinator = RootCoordinator()
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureWindow()
        applicationBootloader.delegate = self
        applicationBootloader.boot()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        rootCoordinator.didRegisterForRemoteNotifications(with: deviceToken)
    }
     
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        rootCoordinator.showRemoteNotificationsErrorAlert()
    }
}

// MARK: - ApplicationBootloaderDelegate

extension AppDelegate: ApplicationBootloaderDelegate {
    
    func didUserDeniedRemoteNotifications() {
        rootCoordinator.showRemoteNotificationsDeniedAlert()
    }
    
    func didFailToRegisterForRemoteNotifications(error: Error?) {
        rootCoordinator.showRemoteNotificationsErrorAlert()
    }
}

// MARK: - Private methods

private extension AppDelegate {
    
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.start()
        window?.rootViewController = rootCoordinator.rootViewController
        window?.makeKeyAndVisible()
    }
}
