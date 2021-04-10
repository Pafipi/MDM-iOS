//
//  HomeCoordinator.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import UIKit
import Core

final class HomeCoordinator: NSObject, StackCoordinable, TabCoordinatorActions {
    
    var childCoordinators: [StackCoordinable]
    var rootNavigationController: NavigationController?
    
    required init(rootNavigationController: NavigationController? = nil) {
        self.rootNavigationController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        let controller = HomeViewController.create()
        controller.delegate = self
        guard let homeIcon = UIImage(named: Constants.String.homeIconName) else { return }
        controller.tabBarItem = self.createTabBarItem(title: Constants.String.homeTabTitle,
                                                      image: homeIcon,
                                                      selectedImage: homeIcon,
                                                      accessbilityIdentifier: Constants.String.homeTabAccessbilityIdentifier,
                                                      accessibilityLabel: Constants.String.homeTabAccessibilityLabel)
        rootNavigationController?.viewControllers.append(controller)
    }
}

// MARK: - HomeViewControllerDelegate

extension HomeCoordinator: HomeViewControllerDelegate {
    
}

// MARK: - Constants

private extension HomeCoordinator {
    
    struct Constants {
        
        struct String {
            static let homeTabTitle = "Home"
            static let homeTabAccessbilityIdentifier = "Home"
            static let homeTabAccessibilityLabel = "Home"
            static let homeIconName = "home_outline"
        }
    }
}
