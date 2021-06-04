//
//  NotificationCenterHelper.swift
//  Core
//
//  Created by Piotr Fraccaro on 25/04/2021.
//

import UIKit

typealias UserInfo = [AnyHashable: Any]?

public final class NotificationCenterHelper {
    
    static let shared = NotificationCenterHelper()
    
    private let notificationCenter: NotificationCenter
    
    private init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
    }
    
    func addObserver(observer: Any, selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        notificationCenter.addObserver(observer, selector: selector, name: name, object: object)
        log(.debug, "\(observer.self) observing \"\(name.rawValue)\"")
    }
    
    func removeObserver(observer: Any, name: NSNotification.Name, object: Any? = nil) {
        notificationCenter.removeObserver(observer, name: name, object: object)
        log(.debug, "\(observer.self) stop observing \"\(name.rawValue)\"")
    }
    
    func post(name: Notification.Name, object: Any?, userInfo: UserInfo) {
        notificationCenter.post(name: name, object: object, userInfo: userInfo)
        log(.event, "\"\(name.rawValue)\"")
    }
}

extension Notification.Name {
    
    static let applicationDidEnterBackground = UIApplication.didEnterBackgroundNotification
    static let applicationWillEnterForeground = UIApplication.willEnterForegroundNotification
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
}
