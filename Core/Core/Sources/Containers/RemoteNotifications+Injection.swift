//
//  RemoteNotifications+Injection.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import UserNotifications
import Resolver

public extension Resolver {
    
    static func registerRemoteNotificationsService() {
        register { UNUserNotificationCenter.current() as UNUserNotificationCenter }
        register { RemoteNotificationsServiceImpl() as RemoteNotificationsService }
    }
}
