//
//  PostDeviceInfoRequestBody.swift
//  DeviceInfo
//
//  Created by Piotr Fraccaro on 06/06/2021.
//

import Foundation

struct PostDeviceInfoRequestBody: Codable {
    
    let deviceId: String
    let name: String
    let systemName: String
    let systemVersion: String
    let model: String
    
    init(deviceId: String,
         name: String,
         systemName: String,
         systemVersion: String,
         model: String) {
        self.deviceId = deviceId
        self.name = name
        self.systemName = systemName
        self.systemVersion = systemVersion
        self.model = model
    }
}
