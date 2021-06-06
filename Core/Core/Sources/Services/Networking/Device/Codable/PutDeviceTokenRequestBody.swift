//
//  PutDeviceTokenRequestBody.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 15/05/2021.
//

import Foundation

struct PutDeviceTokenRequestBody: Codable {

    let deviceId: String
    let deviceToken: String
    
    init(deviceID: String,
         deviceToken: String) {
        self.deviceId = deviceID
        self.deviceToken = deviceToken
    }
}
