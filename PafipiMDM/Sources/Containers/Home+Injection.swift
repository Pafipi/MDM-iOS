//
//  Home+Injection.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver

internal extension Resolver {
    
    static func registerHomeServices() {
        registerHomeScene()
    }
}

private extension Resolver {

    static func registerHomeScene() {
        register { HomeViewModelImpl() as HomeViewModel }
    }
}
