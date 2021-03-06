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
        controller.tabBarItem = self.createTabBarItem(
            title: Localizations.homeTabTitle,
            image: Asset.Home.homeOutline.image,
            selectedImage: Asset.Home.homeOutline.image,
            accessbilityIdentifier: Accessibility.Identifiers.homeTab,
            accessibilityLabel: Accessibility.Labels.homeTab
        )
        rootNavigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - HomeViewControllerDelegate

extension HomeCoordinator: HomeViewControllerDelegate {
    
}
