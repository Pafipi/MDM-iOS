//
//  NotificationCenterHelper.swift
//  Core
//
//  Created by Piotr Fraccaro on 25/04/2021.
//

import UIKit

public typealias UserInfo = [AnyHashable: Any]?

public final class NotificationCenterHelper {
    
    public static let shared = NotificationCenterHelper()
    
    private let notificationCenter: NotificationCenter
    
    private init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
    }
    
    public func addObserver(observer: Any, selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        notificationCenter.addObserver(observer, selector: selector, name: name, object: object)
        log(.debug, "\(observer.self) observing \"\(name.rawValue)\"")
    }
    
    public func removeObserver(observer: Any, name: NSNotification.Name, object: Any? = nil) {
        notificationCenter.removeObserver(observer, name: name, object: object)
        log(.debug, "\(observer.self) stop observing \"\(name.rawValue)\"")
    }
    
    public func post(name: Notification.Name, object: Any?, userInfo: UserInfo) {
        notificationCenter.post(name: name, object: object, userInfo: userInfo)
        log(.event, "\"\(name.rawValue)\"")
    }
}

public extension Notification.Name {
    
    static let applicationDidEnterBackground = UIApplication.didEnterBackgroundNotification
    static let applicationWillEnterForeground = UIApplication.willEnterForegroundNotification
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
    static let batteryLevelDidChange = UIDevice.batteryLevelDidChangeNotification
    static let batteryStateDidChange = UIDevice.batteryStateDidChangeNotification
}
