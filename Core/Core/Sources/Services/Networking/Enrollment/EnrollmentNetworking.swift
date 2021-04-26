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

public protocol EnrollmentNetworking {
    
    func fetchDeviceUUID(with deviceId: String) -> DeviceUUIDPublisher
    func putDeviceToken(_ deviceToken: Data,
                        forDeviceWith deviceUUID: String) -> NetworkingResultPublisher<Bool>
}

final class EnrollmentNetworkingImpl: BaseNetworking, EnrollmentNetworking {
    
    var host: String?

    func fetchDeviceUUID(with deviceId: String) -> DeviceUUIDPublisher {
        let endpoint = EnrollmentEndpoint.getDeviceUUID
        let config = HttpRequestConfig(parameters: ["deviceID": deviceId],
                                       headers: endpoint.headers,
                                       timeout: 15)
        let request = HttpRequest<String>(url: endpoint.url,
                                          method: .get,
                                          requestConfig: config)
        return perform(request)
    }
    
    func putDeviceToken(_ deviceToken: Data,
                        forDeviceWith deviceUUID: String) -> NetworkingResultPublisher<Bool> {
        let endpoint = EnrollmentEndpoint.putDeviceToken
        let config = HttpRequestConfig(parameters: ["deviceUUID": deviceUUID,
                                                    "deviceToken": deviceToken],
                                       headers: endpoint.headers,
                                       timeout: 15)
        let request = HttpRequest<Bool>(url: endpoint.url,
                                        method: .put,
                                        requestConfig: config)
        return perform(request)
    }
}
