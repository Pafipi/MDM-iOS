//
//  Core+Injection.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver
import Core

internal extension Resolver {
    
    static func registerCoreServices() {
        registerRemoteNotificationsService()
        registerNetworking()
        registerValidators()
    }
}
