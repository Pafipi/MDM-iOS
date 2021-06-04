//
//  BaseNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 19/04/2021.
//

class BaseNetworking {

    private let client: HttpClient
    
    init(client: HttpClient = HttpClientImpl(sessionDelegate: HttpURLSessionDelegate())) {
        self.client = client
    }
    
    func perform<T: Codable, U: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<U> {
        return client.perform(request)
    }
}
