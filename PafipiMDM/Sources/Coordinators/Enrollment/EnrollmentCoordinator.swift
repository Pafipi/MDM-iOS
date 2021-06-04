//
//  EnrollmentCoordinator.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Core

protocol EnrollmentCoordinatorInput: AnyObject {
    
    func didRegisterForRemoteNotifications(with deviceToken: Data)
}

final class EnrollmentCoordinator: NSObject, StackCoordinable, TabCoordinatorActions {
    
    weak var enrollmentViewControllerInput: EnrollmentViewControllerInput?
    
    var childCoordinators: [StackCoordinable]
    var rootNavigationController: NavigationController?
    var rootViewController: UIViewController?
    
    required init(rootNavigationController: NavigationController? = nil) {
        self.rootNavigationController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        let controller = EnrollmentViewController.create()
        controller.delegate = self
        enrollmentViewControllerInput = controller
        rootViewController = controller
        rootNavigationController?.viewControllers.append(controller)
    }
    
    func start(with deviceToken: Data? = nil) {
        let controller = EnrollmentViewController.create(with: deviceToken)
        controller.delegate = self
        enrollmentViewControllerInput = controller
        rootViewController = controller
        rootNavigationController?.viewControllers.append(controller)
    }
}

// MARK: - EnrollmentViewControllerDelegate

extension EnrollmentCoordinator: EnrollmentViewControllerDelegate {
    
    func onEnrollmentFinish() { }
}

// MARK: - EnrollmentViewControllerDelegate

extension EnrollmentCoordinator: EnrollmentCoordinatorInput {
    
    func didRegisterForRemoteNotifications(with deviceToken: Data) {
        enrollmentViewControllerInput?.didRegisterForRemoteNotifications(with: deviceToken)
    }
}
