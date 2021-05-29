//
//  EnrollmentNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Combine
import Resolver

public typealias DeviceUUIDPublisher = NetworkingResultPublisher<String>
public typealias PutDeviceTokenPublisher = NetworkingResultPublisher<EmptyResponse>

public protocol EnrollmentNetworking {
    
    func fetchDeviceUUID(with deviceId: String) -> DeviceUUIDPublisher
    func putDeviceToken(_ deviceToken: Data, forDeviceWith deviceID: String) -> PutDeviceTokenPublisher
}

final class EnrollmentNetworkingImpl: BaseNetworking, EnrollmentNetworking {
    
    var host: String?

    func fetchDeviceUUID(with deviceId: String) -> DeviceUUIDPublisher {
        let endpoint = EnrollmentEndpoint.getDeviceUUID
        let config = HttpRequestConfig(parameters: [Constants.deviceIDParameterKey: deviceId],
                                       headers: endpoint.headers,
                                       timeout: Constants.fetchDeviceUUIDTimeout)
        let request = HttpRequest<String>(url: endpoint.url,
                                          method: .get,
                                          requestConfig: config)
        return perform(request)
    }
    
    func putDeviceToken(_ deviceToken: Data, forDeviceWith deviceID: String) -> PutDeviceTokenPublisher {
        let endpoint = EnrollmentEndpoint.putDeviceToken
        let config = HttpRequestConfig(parameters: [:],
                                       headers: endpoint.headers,
                                       timeout: Constants.putDeviceTokenTimeout)
        let request = HttpRequest(url: endpoint.url,
                                  method: .put,
                                  body: PutDeviceTokenRequestBody(
                                    deviceID: deviceID,
                                    deviceToken: deviceToken),
                                  requestConfig: config)
        return perform(request)
    }
}

// MARK: - Constants

private extension EnrollmentNetworkingImpl {
    
    struct Constants {
        static let deviceIDParameterKey: String = "deviceID"
        static let deviceTokenParameterKey: String = "deviceToken"
        static let putDeviceTokenParameterKey: String = "putDeviceTokenViewModel"
        static let fetchDeviceUUIDTimeout: TimeInterval = 120
        static let putDeviceTokenTimeout: TimeInterval = 120
    }
}
