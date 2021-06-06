//
//  DeviceInfo+Injection.swift
//  DeviceInfo
//
//  Created by Piotr Fraccaro on 06/06/2021.
//

import Resolver

public extension Resolver {
    
    static func registerDeviceInfoServices() {
        register { DeviceInfoNetworkingImpl() as DeviceInfoNetworking }
        register { DeviceInfoServiceImpl() as DeviceInfoService }
    }
}
