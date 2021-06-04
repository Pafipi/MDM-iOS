//
//  EnrollmentEndpoint.swift
//  Core
//
//  Created by Piotr Fraccaro on 30/05/2021.
//

import Foundation

struct EnrollmentEndpoint: Endpoint {
    
    var host: String
    var path: String
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.port = 443
        components.path = "/api" + path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: Headers {
        return [
            "x-apikey": "795ad45e4dc222bc0e5bd1c163bb885e3635e",
            "content-type": "application/json"
        ]
    }
    
    var queryItems: [URLQueryItem] = []
}

// MARK: - Enrollment API

extension EnrollmentEndpoint {
    
    static var requestEnrollmentPush: Self {
        return EnrollmentEndpoint(host: UserDefaults.mdmServerAddress ?? "", path: "/enroll")
    }
}
