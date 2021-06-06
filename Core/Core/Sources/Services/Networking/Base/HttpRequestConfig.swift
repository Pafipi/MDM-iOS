//
//  HttpRequestConfig.swift
//  Core
//
//  Created by Piotr Fraccaro on 12/04/2021.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public struct HttpRequestConfig {
    
    var parameters: Parameters
    var headers: Headers
    var timeout: TimeInterval
    
    public init(
        parameters: Parameters,
        headers: Headers,
        timeout: TimeInterval) {
        self.parameters = parameters
        self.headers = headers
        self.timeout = timeout
    }
}

extension Parameters {
    
    func asQueryItems() -> [URLQueryItem] {
        self.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
