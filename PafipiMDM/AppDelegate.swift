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
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureWindow()
        applicationBootloader.delegate = self
//        applicationBootloader?.boot()
        
        return true
    }
}

// MARK: - ApplicationBootloaderDelegate

extension AppDelegate: ApplicationBootloaderDelegate {
    
    func didUserDeniedRemoteNotifications() {
        showRemoteNotificationsDeniedAlert()
    }
    
    func didFailToRegisterForRemoteNotifications(error: Error?) {
        showRemoteNotificationsErrorAlert()
    }
}

// MARK: - Private methods

private extension AppDelegate {
    
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = RootCoordinator()
        rootCoordinator.start()
        window?.rootViewController = rootCoordinator.rootViewController
        window?.makeKeyAndVisible()
    }
    
    func showRemoteNotificationsDeniedAlert() {
        let alert = getRemoteNotificationsDeniedAlert()
        window?.rootViewController?.present(alert, animated: true)
    }
    
    func showRemoteNotificationsErrorAlert() {
        let alert = getRemoteNotificationsErrorAlert()
        window?.rootViewController?.present(alert, animated: true)
    }
    
    func getRemoteNotificationsDeniedAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: LocalizedStrings.RemoteNotifications.permissionDeniedAlertTitle,
            message: LocalizedStrings.RemoteNotifications.permissionDeniedAlertMessage,
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(
            title: LocalizedStrings.Common.settings,
            style: .default) { _ in
                self.openSystemSettings()
        }
        
        alert.addAction(settingsAction)
        
        return alert
    }
    
    func getRemoteNotificationsErrorAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: LocalizedStrings.RemoteNotifications.permissionErrorAlertTitle,
            message: LocalizedStrings.RemoteNotifications.permissionErrorAlertMessage,
            preferredStyle: .alert
        )
        
        return alert
    }
    
    func openSystemSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else { return }
        
        UIApplication.shared.open(settingsUrl)
    }
}
