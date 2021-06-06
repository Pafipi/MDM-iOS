//
//  BatteryInfo+Injection.swift
//  BatteryInfo
//
//  Created by Piotr Fraccaro on 05/06/2021.
//

import Foundation
import Resolver

public extension Resolver {
    
    static func registerBatteryInfoServices() {
        register { BatteryInfoNetworkingImpl() as BatteryInfoNetworking }
        register { BatteryInfoServiceImpl() as BatteryInfoService }
    }
}
