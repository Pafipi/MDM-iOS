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
    
    func perform<T: Codable, R: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<R> {
        return client.perform(request)
    }
}
