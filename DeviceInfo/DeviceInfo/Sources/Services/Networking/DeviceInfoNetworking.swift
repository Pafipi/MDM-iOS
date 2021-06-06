//
//  DeviceInfoNetworking.swift
//  DeviceInfo
//
//  Created by Piotr Fraccaro on 06/06/2021.
//

import Core

protocol DeviceInfoNetworking {
    
    func postDeviceInfo(requestBody: PostDeviceInfoRequestBody) -> NetworkingEmptyResultPublisher
}

final class DeviceInfoNetworkingImpl: BaseNetworking, DeviceInfoNetworking {
    
    func postDeviceInfo(requestBody: PostDeviceInfoRequestBody) -> NetworkingEmptyResultPublisher {
        let endpoint = DeviceInfoEndpoint.deviceInfo
        let config = HttpRequestConfig(
            parameters: [:],
            headers: endpoint.headers,
            timeout: Constants.postDeviceInfoTimeout
        )
        let request = HttpRequest(
            url: endpoint.url,
            method: .post,
            body: requestBody,
            requestConfig: config
        )
        return perform(request)
    }
}

// MARK: - Constants

private struct Constants {
    
    static let postDeviceInfoTimeout: TimeInterval = 30
}
