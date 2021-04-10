//
//  StackCoordinable.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit
import Core

protocol StackCoordinable: NSObject, UINavigationControllerDelegate, Coordinable, CoordinatorActions {
    
    var childCoordinators: [StackCoordinable] { get set }
}

// MARK: StackCoordinable Extension

extension StackCoordinable where Self: Coordinable {
    
    func didFinish(_ child: StackCoordinable?) {
        guard let child = child else { return }
        self.childCoordinators.enumerated().forEach {
            if $0.element === child {
                childCoordinators.remove(at: $0.offset)
            }
        }
    }
    
    func add(_ child: StackCoordinable?) {
        if let child = child {
            self.childCoordinators.append(child)
        }
    }
    
    func removeAllChildren(_ child: StackCoordinable) {
        childCoordinators.removeAll { $0 == child  }
    }
    
    func removeChild(_ child: StackCoordinable) {

        let index = childCoordinators.lastIndex { stackCoordinable -> Bool in
            return stackCoordinable == child
        }
        if let indexToRemove = index {
            childCoordinators.remove(at: indexToRemove)
        }
    }
    
    func removeFromStack(_ navigationController: UINavigationController) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let destVC = fromViewController as? StackableViewController {
            self.didFinish(destVC.stackCoordinatorDelegate)
        }
    }
    
    func update(navigationController: NavigationController?) {
        self.rootNavigationController = navigationController
    }
}
