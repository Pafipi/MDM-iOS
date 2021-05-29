//
//  EnrollmentEndpoint.swift
//  Core
//
//  Created by Piotr Fraccaro on 20/04/2021.
//

import Foundation

struct EnrollmentEndpoint {
    
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
}

// MARK: - Enrollment API

extension EnrollmentEndpoint {
    
    static var getDeviceUUID: Self {
        return EnrollmentEndpoint(host: UserDefaults.mdmServerAddress ?? "", path: "/device")
    }
    
    static var putDeviceToken: Self {
        return EnrollmentEndpoint(host: UserDefaults.mdmServerAddress ?? "", path: "/device/update")
    }
}
