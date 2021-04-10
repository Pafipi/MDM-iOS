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

typealias Parameters = [String: Any]
typealias Headers = [String: String]
typealias NetworkingCompletion<T: Codable> = (Result<T, Error>) -> Void

final class HttpRequest<T: Codable> {
    
    let url: String
    let method: HttpMethod
    let parameters: Parameters
    let headers: HeaderFactory
    let completion: NetworkingCompletion<T>?
    
    init(url: String,
         method: HttpMethod,
         parameters: Parameters = [:],
         headers: HeaderFactory = .apiDefault,
         completion: NetworkingCompletion<T>?) {
        
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.completion = completion
    }
    
    var string: String {
        """
        [\(method.rawValue.uppercased())] \(url)
        Headers: \(headers)
        Parameters: \(parameters)
        """
    }
}
