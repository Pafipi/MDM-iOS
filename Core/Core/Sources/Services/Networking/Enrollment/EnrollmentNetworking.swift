//
//  EnrollmentNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 30/05/2021.
//

import Foundation
import Combine
import Resolver

public protocol EnrollmentNetworking {
    
    func requestEnrollmentPush(for deviceId: String) -> NetworkingEmptyResultPublisher
}

final class EnrollmentNetworkingImpl: BaseNetworking, EnrollmentNetworking {
    
    func requestEnrollmentPush(for deviceId: String) -> NetworkingEmptyResultPublisher {
        let endpoint = EnrollmentEndpoint.requestEnrollmentPush
        let config = HttpRequestConfig(
            parameters: [Constants.deviceIDParameterKey: deviceId],
            headers: endpoint.headers,
            timeout: Constants.requestEnrollmentPushTimeout
        )
        let request = HttpRequest<EmptyResponse>(
            url: endpoint.url,
            method: .get,
            requestConfig: config
        )
        return perform(request)
    }
}

// MARK: - Constants

private extension EnrollmentNetworkingImpl {
    
    struct Constants {
        static let deviceIDParameterKey: String = "deviceID"
        static let requestEnrollmentPushTimeout: TimeInterval = 30
    }
}
