//
//  HttpRequest.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

enum HttpMethod: String {
    case get
    case post
    case put
}

final class HttpRequest<T> {
    
    let url: URL
    let method: HttpMethod
    let body: T?
    let config: HttpRequestConfig
    
    var parameters: Parameters {
        config.parameters
    }
    
    var headers: Headers {
        config.headers
    }
    
    var timeout: TimeInterval {
        config.timeout
    }
    
    init(url: URL,
         method: HttpMethod,
         body: T? = nil,
         requestConfig: HttpRequestConfig) {
        self.url = url
        self.method = method
        self.body = body
        self.config = requestConfig
    }
    
    var string: String {
        """
        [\(method.rawValue.uppercased())] \(url)
        Headers: \(headers)
        Parameters: \(parameters)
        Body: \(String(data: (try? JSONEncoder().encode(body)) ?? Data(), encoding: .utf8) ?? "")
        """
    }
}
