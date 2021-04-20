//
//  BaseNetworking.swift
//  Core
//
//  Created by Piotr Fraccaro on 19/04/2021.
//

class BaseNetworking {

    private let client: HttpClient
    
    init(client: HttpClient = HttpClientImpl()) {
        self.client = client
    }
    
    func perform<T: Codable>(_ request: HttpRequest<T>) -> NetworkingResult<T> {
        return client.perform(request)
    }
}
