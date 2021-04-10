//
//  BaseNetworking.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

class BaseNetworking {

    private let manager: HttpClient
    
    init(manager: HttpClient = HttpClient.shared) {
        self.manager = manager
    }
    
    func perform<T: Codable>(_ request: HttpRequest<T>) {
        manager.perform(request)
    }
}
