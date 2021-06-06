//
//  BatteryNetworking.swift
//  BatteryInfo
//
//  Created by Piotr Fraccaro on 05/06/2021.
//

import Combine
import Core
import Resolver

protocol BatteryNetworking {
    
    func postBatteryLevel(level: Float, forDeviceWith uuid: String) -> NetworkingEmptyResultPublisher
    func postBatteryState(state: Int, forDeviceWith uuid: String) -> NetworkingEmptyResultPublisher
}

final class BatteryNetworkingImpl: BaseNetworking, BatteryNetworking {
    
    func postBatteryLevel(level: Float, forDeviceWith uuid: String) -> NetworkingEmptyResultPublisher {
        let endpoint = BatteryEndpoint.batteryLevel
        let config = HttpRequestConfig(
            parameters: [:],
            headers: endpoint.headers,
            timeout: Constants.requestEnrollmentPushTimeout
        )
        let request = HttpRequest(
            url: endpoint.url,
            method: .post,
            body: PostBatteryLevelRequestBody(
                deviceId: uuid,
                batteryLevel: level
            ),
            requestConfig: config
        )
        return perform(request)
    }
    
    func postBatteryState(state: Int, forDeviceWith uuid: String) -> NetworkingEmptyResultPublisher {
        let endpoint = BatteryEndpoint.batteryStatus
        let config = HttpRequestConfig(
            parameters: [:],
            headers: endpoint.headers,
            timeout: Constants.requestEnrollmentPushTimeout
        )
        let request = HttpRequest(
            url: endpoint.url,
            method: .post,
            body: PostBatteryStateRequestBody(
                deviceId: uuid,
                batteryState: state
            ),
            requestConfig: config
        )
        return perform(request)
    }
}

// MARK: - Constants

private extension BatteryNetworkingImpl {
    
    struct Constants {
        static let deviceUuidParameterKey: String = "deviceID"
        static let requestEnrollmentPushTimeout: TimeInterval = 30
    }
}
