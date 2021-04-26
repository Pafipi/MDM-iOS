//
//  RootCoordinator.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit
import Resolver
import Core

final class RootCoordinator: NSObject, StackCoordinable, TabCoordinatorActions {
    
    weak var enrollmentCoordinatorInput: EnrollmentCoordinatorInput?
    
    var childCoordinators: [StackCoordinable]
    var rootNavigationController: NavigationController?
    var rootViewController: UIViewController?
    
    private var deviceToken: Data?
    
    required init(rootNavigationController: NavigationController? = nil) {
        self.rootNavigationController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        var tabBarViews: [UIViewController] = []
        
        let homeNavigationController = NavigationController()
        let homeCoordinator = HomeCoordinator(rootNavigationController: homeNavigationController)
        add(homeCoordinator)
        homeCoordinator.start()
        tabBarViews.append(homeNavigationController)
        
        if KeychainWrapper.deviceUUID == nil {
            let enrollmentCoordinator = EnrollmentCoordinator()
            enrollmentCoordinator.start(with: deviceToken)
            rootViewController = enrollmentCoordinator.rootViewController
            enrollmentCoordinatorInput = enrollmentCoordinator
            add(enrollmentCoordinator)
        } else {
            let rootTabBarController = RootTabBarController(tabBarViews: tabBarViews)
            rootTabBarController.controllerDelegate = self
            rootViewController = rootTabBarController
        }
    }
    
    func didRegisterForRemoteNotifications(with deviceToken: Data) {
        self.deviceToken = deviceToken
        enrollmentCoordinatorInput?.didRegisterForRemoteNotifications(with: deviceToken)
    }
    
    func showRemoteNotificationsDeniedAlert() {
        Thread.asyncOnMain { [weak self] in
            guard let self = self else { return }
            let alert = self.getRemoteNotificationsDeniedAlert()
            self.rootViewController?.present(alert, animated: true)
        }
    }
    
    func showRemoteNotificationsErrorAlert() {
        Thread.asyncOnMain { [weak self] in
            guard let self = self else { return }
            let alert = self.getRemoteNotificationsErrorAlert()
            self.rootViewController?.present(alert, animated: true)
        }
    }
    
    func getRemoteNotificationsDeniedAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: Localizations.remoteNotificationsDeniedAlertTitle,
            message: Localizations.remoteNotificationsDeniedAlertMessage,
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(
            title: Localizations.settings,
            style: .default) { _ in
                self.openSystemSettings()
        }
        
        alert.addAction(settingsAction)
        
        return alert
    }
    
    func getRemoteNotificationsErrorAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: Localizations.remoteNotificationsErrorAlertTitle,
            message: Localizations.remoteNotificationsErrorAlertMessage,
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

// MARK: - EnrollmentViewControllerDelegate

extension RootCoordinator: EnrollmentViewControllerDelegate {
    
}

// MARK: - RootTabBarControllerDelegate

extension RootCoordinator: RootTabBarControllerDelegate {
    
}
