//
//  PutDeviceTokenRequestBody.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 15/05/2021.
//

import Foundation

struct PutDeviceTokenRequestBody: Codable {

    let deviceID: String
    let deviceToken: Data
    
    init(deviceID: String,
         deviceToken: Data) {
        self.deviceID = deviceID
        self.deviceToken = deviceToken
    }
}
