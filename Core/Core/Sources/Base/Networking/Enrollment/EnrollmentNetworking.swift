//
//  EnrollmentNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Combine
import Resolver

public protocol EnrollmentNetworking {
    
    func getUsers() -> AnyPublisher<Users, Error>
}

final class EnrollmentNetworkingImpl: BaseNetworking, EnrollmentNetworking {
        
    func getUsers() -> AnyPublisher<Users, Error> {
        let endpoint = BaseEndpoint.users
        let config = HttpRequestConfig(parameters: [:],
                                       headers: endpoint.headers,
                                       timeout: 30)
        let request = HttpRequest<Users>(url: endpoint.url,
                                         method: .get,
                                         requestConfig: config)
        return perform(request)
    }
}
