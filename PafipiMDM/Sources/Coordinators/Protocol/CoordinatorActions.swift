//
//  CoordinatorActions.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit
import Core

// Protocol for the actions needed for objects conforming to coordinator actions
protocol CoordinatorActions {
    
    /// Function to start the flow, this is where the flow is init so do any custom logic here
    func start()
    
    /// Removes a child coordinator from the array, if it's found on the navigation stack
    ///
    /// - Parameter navigationController: The current navigationcontroller from
    /// `navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)`
    mutating func removeFromStack(_ navigationController: UINavigationController)
    
    /// Tell the navigation stack that an object has been removed from it
    ///
    /// - Parameter child: The stack coordinator object
    mutating func didFinish(_ child: StackCoordinable?)
    
    /// Adds a stack coordinator object into child coordinator array, that is used to manage the navigation stack
    ///
    /// - Parameter child: The stack coordinator object
    mutating func add(_ child: StackCoordinable?)
    
    /// Update the main navigation controlle that is responsible for pushing, popping and presenting view controllers
    ///
    /// - Parameter navigationController: The root navigation controller of the coordinator
    mutating func update(navigationController: NavigationController?)
}
