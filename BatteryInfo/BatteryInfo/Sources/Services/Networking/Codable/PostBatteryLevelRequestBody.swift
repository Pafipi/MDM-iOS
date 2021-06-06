//
//  PostBatteryLevelRequestBody.swift
//  BatteryInfo
//
//  Created by Piotr Fraccaro on 05/06/2021.
//

import Foundation

struct PostBatteryLevelRequestBody: Codable {
    
    let deviceId: String
    let batteryLevel: Float
    
    init(deviceId: String,
         batteryLevel: Float) {
        self.deviceId = deviceId
        self.batteryLevel = batteryLevel
    }
}
