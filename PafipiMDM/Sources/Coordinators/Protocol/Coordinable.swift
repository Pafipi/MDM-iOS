//
//  Coordinable.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit
import Core

// Base protocol for defining the root navigation controller that will be used to manage the flow
protocol Coordinable: AnyObject {
    
    /// The root navigation controller object that will be used to either present or push the current view controller
    var rootNavigationController: NavigationController? { get set }
    
    /// Initializer to set the root navigation controller object
    ///
    /// - Parameter rootNavigationController: The root navigation controller object that will be used to either present or push the current vc
    init(rootNavigationController: NavigationController?)
}
