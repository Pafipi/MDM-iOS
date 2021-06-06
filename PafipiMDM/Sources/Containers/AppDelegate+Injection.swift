//
//  AppDelegate+Injection.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerCoreServices()
        registerRootScene()
        registerHomeScene()
        registerEnrollmentScene()
        registerBatteryInfoServices()
    }
}
