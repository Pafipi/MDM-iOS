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
    
    required init(rootNavigationController: NavigationController? = NavigationController()) {
        self.rootNavigationController = rootNavigationController
        self.rootViewController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        var tabBarViews: [UIViewController] = []
        
        guard let homeNavigationController = rootNavigationController else { return }
        let homeCoordinator = HomeCoordinator(rootNavigationController: homeNavigationController)
        add(homeCoordinator)
        homeCoordinator.start()
        tabBarViews.append(homeNavigationController)
        let rootTabBarController = RootTabBarController(tabBarViews: tabBarViews)
        rootTabBarController.controllerDelegate = self
        rootViewController = rootTabBarController
        
        if !UserDefaults.isEnrolled {
            let enrollmentCoordinator = EnrollmentCoordinator(rootNavigationController: rootNavigationController)
            enrollmentCoordinator.delegate = self
            add(enrollmentCoordinator)
            enrollmentCoordinator.start(with: deviceToken)
            enrollmentCoordinatorInput = enrollmentCoordinator
        }
    }
    
    func didRegisterForRemoteNotifications(with deviceToken: Data) {
        self.deviceToken = deviceToken
        enrollmentCoordinatorInput?.didRegisterForRemoteNotifications(with: deviceToken)
    }
    
    func showMobileConfigInstallationScene() {
        let mobileConfigCoordinator = MobileConfigCoordinator(rootNavigationController: rootNavigationController)
        mobileConfigCoordinator.delegate = self
        add(mobileConfigCoordinator)
        mobileConfigCoordinator.start()
        rootViewController = mobileConfigCoordinator.rootNavigationController
    }
    
    func showRemoteNotificationsDeniedAlert() {
        Thread.asyncOnMain { [weak self] in
            guard let self = self else { return }
            let alert = self.getRemoteNotificationsDeniedAlert()
            self.rootNavigationController?.present(alert, animated: true)
        }
    }
    
    func showRemoteNotificationsErrorAlert() {
        Thread.asyncOnMain { [weak self] in
            guard let self = self else { return }
            let alert = self.getRemoteNotificationsErrorAlert()
            self.rootNavigationController?.present(alert, animated: true)
        }
    }
    
    func getRemoteNotificationsDeniedAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: Localizations.remoteNotificationsDeniedAlertTitle,
            message: Localizations.remoteNotificationsDeniedAlertMessage,
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(
            title: CoreLocalizations.settings,
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

// MARK: - EnrollmentCoordinatorDelegate

extension RootCoordinator: EnrollmentCoordinatorDelegate {
    
    func didFinish(coordinator: EnrollmentCoordinator) {
        removeChild(coordinator)
    }
}

// MARK: - MobileConfigCoordinatorDelegate

extension RootCoordinator: MobileConfigCoordinatorDelegate {
    
    func didFinish(coordinator: MobileConfigCoordinator) {
        removeChild(coordinator)
        rootNavigationController?.popViewController(animated: true)
        UserDefaults.isEnrolled = true
    }
}

// MARK: - RootTabBarControllerDelegate

extension RootCoordinator: RootTabBarControllerDelegate {
    
}
