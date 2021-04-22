//
//  ApplicationBootloader.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 21/03/2021.
//

import Foundation
import Resolver
import Core

/// Application bootloader
/// Boots all services after app launch
protocol ApplicationBootloader {
    
    var delegate: ApplicationBootloaderDelegate? { get set }
    
    /// Main booloader function, should be called in
    /// func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func boot()
}

protocol ApplicationBootloaderDelegate: AnyObject {
    func didUserDeniedRemoteNotifications()
    func didFailToRegisterForRemoteNotifications(error: Error?)
}

final class ApplicationBootloaderImpl {
    
    weak var delegate: ApplicationBootloaderDelegate?
    
    @LazyInjected private var remoteNotificationsService: RemoteNotificationsService
    
}

// MARK: - ApplicationBootloader

extension ApplicationBootloaderImpl: ApplicationBootloader {
    
    func boot() {
        registerForRemoteNotifications()
    }
}

// MARK: - Private methods

private extension ApplicationBootloaderImpl {
    
    func registerForRemoteNotifications() {
        remoteNotificationsService.getAuthorizationStatus { status in
            switch status {
            case .granted:
                self.remoteNotificationsService.registerForRemoteNotifications()
            case .denied, .provisional, .ephemeral:
                self.delegate?.didUserDeniedRemoteNotifications()
            default:
                self.requestUserAuthForRemoteNotifications()
            }
        }
    }
    
    func requestUserAuthForRemoteNotifications() {
        remoteNotificationsService.requestAuthorization { _, error in
            if let error = error {
                self.delegate?.didFailToRegisterForRemoteNotifications(error: error)
            } else {
                self.registerForRemoteNotifications()
            }
        }
    }
}
