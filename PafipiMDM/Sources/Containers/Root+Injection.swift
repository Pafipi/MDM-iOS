//
//  Root+Injection.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver

internal extension Resolver {
    
    static func registerRootScene() {
        register { RootTabBarViewModelImpl() as RootTabBarViewModel }
    }
}
