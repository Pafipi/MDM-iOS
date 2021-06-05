//
//  MobileConfigCoordinator.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 04/06/2021.
//

import Foundation
import Core

protocol MobileConfigCoordinatorDelegate: AnyObject {
    
    func didFinish(coordinator: MobileConfigCoordinator)
}

final class MobileConfigCoordinator: NSObject, StackCoordinable, TabCoordinatorActions {
    
    weak var delegate: MobileConfigCoordinatorDelegate?
    
    var childCoordinators: [StackCoordinable]
    var rootNavigationController: NavigationController?
    
    init(rootNavigationController: NavigationController? = nil) {
        self.rootNavigationController = rootNavigationController
        self.childCoordinators = []
        super.init()
    }
    
    func start() {
        guard let mobileConfigURL = URL(
            string: "https://xn-mgqaaaabaa.eu"// + Constants.mobileConfigFilePath
        ) else { return }
        let controller = MobileConfigViewController.create(with: mobileConfigURL)
        controller.viewControllerDelegate = self

        rootNavigationController?.present(controller, animated: true)
    }
}

// MARK: - MobileConfigViewController

extension MobileConfigCoordinator: MobileConfigViewControllerDelegate {
    
    func didFinish() {
        delegate?.didFinish(coordinator: self)
    }
}

// MARK: - Constants

private struct Constants {
    
    static let mobileConfigFilePath = "/drop.html"
}
