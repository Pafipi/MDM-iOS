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
}

// MARK: - EnrollmentViewControllerDelegate

extension RootCoordinator: EnrollmentViewControllerDelegate {
    
}

// MARK: - RootTabBarControllerDelegate

extension RootCoordinator: RootTabBarControllerDelegate {
    
}
