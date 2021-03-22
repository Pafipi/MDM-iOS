//
//  LocalizedStrings.swift
//  Core
//
//  Created by Piotr Fraccaro on 21/03/2021.
//

import Foundation

public struct LocalizedStrings {
    
    public struct Common {
        public static let settings = "settings".localized()
    }
    
    public struct RemoteNotifications {
        public static let permissionDeniedAlertTitle = "remote_notifications_denied_alert_title".localized()
        public static let permissionDeniedAlertMessage = "remote_notifications_denied_alert_message".localized()
        public static let permissionErrorAlertTitle = "remote_notifications_error_alert_title".localized()
        public static let permissionErrorAlertMessage = "remote_notifications_error_alert_message".localized()
    }
}
