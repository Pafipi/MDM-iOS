//
//  RemoteNotificationsService.swift
//  Core
//
//  Created by Piotr Fraccaro on 20/03/2021.
//

import UIKit
import UserNotifications
import Resolver

public typealias PushAuthStatusResponse = (AuthorizationStatus) -> Void
public typealias UserAuthorizationResponse = (Bool, Error?) -> Void

public enum AuthorizationStatus: Int {
    case notDetermined
    case denied
    case granted
    case provisional
    case ephemeral
}

public protocol RemoteNotificationsService {
    
    /// Requests authorization statuts and returns it as callback parameter
    /// - parameter completion: block of code invoked after getting authorizatiton status
    func getAuthorizationStatus(completion: PushAuthStatusResponse)
    
    /// Requests user authorization for remote notifications with alerts, sounds and badges
    /// - parameter completion: escaping block of code invoked after getting user response for authorization request or api error
    func requestAuthorization(completion: @escaping UserAuthorizationResponse)
    
    /// Registers application in remote notifications service
    func registerForRemoteNotifications()
}

final class RemoteNotificationsServiceImpl: NSObject, RemoteNotificationsService {
    
    @Injected private var notificationCenter: UNUserNotificationCenter
    
    private var authorizationStatus: AuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func getAuthorizationStatus(completion: PushAuthStatusResponse) {
        notificationCenter.getNotificationSettings { settings in
            let authStatus = settings.authorizationStatus
            self.authorizationStatus = AuthorizationStatus(
                rawValue: authStatus.rawValue
            ) ?? .notDetermined
            log(.debug, "Current remote notification auth status: \(authStatus).")
        }
    }
    
    func requestAuthorization(completion: @escaping UserAuthorizationResponse) {
        guard authorizationStatus != .granted else { return }
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { granted, error in
            completion(granted, error)
            if granted {
                self.authorizationStatus = .granted
                log(.success, "User has authorized for remote notifications.")
            } else {
                self.authorizationStatus = .denied
                log(.warning, "User denied remote notifications authorization.")
            }
        }
        log(.debug, "User has been requested for remote notifications authorization.")
    }
    
    func registerForRemoteNotifications() {
        guard authorizationStatus == .granted else { return }
        Thread.asyncOnMain {
            UIApplication.shared.registerForRemoteNotifications()
        }
        log(.debug, "App has requested for registration in remote notification service.")
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension RemoteNotificationsServiceImpl: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }

    @available(iOS 12.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
}
