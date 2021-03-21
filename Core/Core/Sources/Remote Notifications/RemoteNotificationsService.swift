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

final class RemoteNotificationsServiceImpl: NSObject {
    
    @Injected private var notificationCenter: UNUserNotificationCenter
    
    private var authorizationStatus: AuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
}

// MARK: - RemoteNotificationsService

extension RemoteNotificationsServiceImpl: RemoteNotificationsService {
    
    func getAuthorizationStatus(completion: PushAuthStatusResponse) {
        notificationCenter.getNotificationSettings { settings in
            let authStatus = settings.authorizationStatus
            self.authorizationStatus = AuthorizationStatus(
                rawValue: authStatus.rawValue
            ) ?? .notDetermined
        }
    }
    
    func requestAuthorization(completion: @escaping UserAuthorizationResponse) {
        guard authorizationStatus != .granted else { return }
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { granted, error in
                completion(granted, error)
                self.authorizationStatus = granted ? .granted : .denied
            }
    }
    
    func registerForRemoteNotifications() {
        guard authorizationStatus == .granted else { return }
        Thread.asyncOnMain {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
