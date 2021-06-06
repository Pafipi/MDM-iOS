//
//  BaseNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 19/04/2021.
//

open class BaseNetworking {

    private let client: HttpClient
    
    public init(client: HttpClient = HttpClientImpl(sessionDelegate: HttpURLSessionDelegate())) {
        self.client = client
    }
    
    public func perform<T: Codable, U: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<U> {
        return client.perform(request)
    }
}
