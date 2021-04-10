//
//  RootCoordinator.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit
import Core

final class RootCoordinator: NSObject, StackCoordinable, TabCoordinatorActions {
    
    var childCoordinators: [StackCoordinable]
    var rootNavigationController: NavigationController?
    var rootViewController: UIViewController?
    
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
        
        let rootTabBarController = RootTabBarController(tabBarViews: tabBarViews)
        rootTabBarController.controllerDelegate = self
        rootViewController = rootTabBarController
    }
}

// MARK: - RootTabBarControllerDelegate

extension RootCoordinator: RootTabBarControllerDelegate {
    
}
