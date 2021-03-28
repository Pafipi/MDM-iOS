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
    
    required init(rootNavigationController: NavigationController? = nil) {
        self.rootNavigationController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        var tabBarViews: [UIViewController] = []
        
    }
}
