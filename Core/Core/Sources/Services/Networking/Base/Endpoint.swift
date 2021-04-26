//
//  Endpoint.swift
//  Core
//
//  Created by Piotr Fraccaro on 12/04/2021.
//

import Foundation

protocol Endpoint {
    
    var url: URL { get }
    var headers: Headers { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get set }
}

struct BaseEndpoint: Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyapi.io"
        components.path = "/data/api" + path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: Headers {
        return [
            "app-id": "6073ea47b9894f8928e75229"
        ]
    }
    
    var path: String
    var queryItems: [URLQueryItem] = []
}

// MARK: - DUMMY
#warning("DUMMY API")
extension BaseEndpoint {
    
    static var users: Self {
        return BaseEndpoint(path: "/user")
    }
    
    static func users(count: Int) -> Self {
        return BaseEndpoint(
            path: "/user",
            queryItems: [URLQueryItem(name: "limit",
                                      value: "\(count)")]
        )
    }
    
    static func user(id: String) -> Self {
        return BaseEndpoint(path: "/user/\(id)")
    }
}
