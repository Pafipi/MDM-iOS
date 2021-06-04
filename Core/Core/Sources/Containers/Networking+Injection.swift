//
//  Networking+Injection.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation
import Resolver

public extension Resolver {
    
    static func registerNetworking() {
        register { DeviceNetworkingImpl() as DeviceNetworking }
        register { EnrollmentNetworkingImpl() as EnrollmentNetworking }
    }
}
