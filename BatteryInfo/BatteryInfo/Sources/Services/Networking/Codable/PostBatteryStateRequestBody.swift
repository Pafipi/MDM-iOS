//
//  PostBatteryStateRequestBody.swift
//  BatteryInfo
//
//  Created by Piotr Fraccaro on 05/06/2021.
//

import Foundation

struct PostBatteryStateRequestBody: Codable {
    
    let deviceId: String
    let batteryState: Int
    
    init(deviceId: String,
         batteryState: Int) {
        self.deviceId = deviceId
        self.batteryState = batteryState
    }
}
