//
//  HttpClient.swift
//  IteoTemplate
//
//  Created by Piotr Fraccaro on 19/04/2021.
//

import Foundation
import Combine

public typealias NetworkingResultPublisher<T: Codable> = AnyPublisher<T, Error>

public struct EmptyResponse: Codable { }

protocol HttpClient: AnyObject {
    
    func perform<T: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<T>
}

final class HttpClientImpl: NSObject, HttpClient {
    
    private let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
         sessionDelegate: URLSessionDelegate) {
        self.session = URLSession(configuration: sessionConfiguration,
                                  delegate: sessionDelegate,
                                  delegateQueue: OperationQueue())
        super.init()
    }
    
    func perform<T: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<T> {
        log(.networkRequest, "\(request.string)")
        
        guard var components = URLComponents(url: request.url, resolvingAgainstBaseURL: true) else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        if request.method == .get {
            components.queryItems = components.queryItems != nil ? components.queryItems : [URLQueryItem]()
            components.queryItems?.append(contentsOf: request.parameters.asQueryItems())
        }
        
        guard let url = components.url else {
            return Fail(error: NetworkingError.invalidURLParameters).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: request.timeout)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        request.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if request.method != .get && !request.parameters.isEmpty {
            guard let data = try? JSONSerialization.data(withJSONObject: request.parameters, options: [])
            else {
                return Fail(error: NetworkingError.invalidJSONParameters).eraseToAnyPublisher()
            }
            urlRequest.httpBody = data
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .networkingResultPublisher(for: request)
    }
}

private extension URLSession.DataTaskPublisher {
    
    func networkingResultPublisher<T: Codable>(for request: HttpRequest<T>) -> NetworkingResultPublisher<T> {
        tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.notHttpResponse
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkingError.apiError(code: httpResponse.statusCode, data: data)
            }

            log(.networkResponse,
                """
                🟢 Request: \(request.string)
                Response: \(data.stringValue ?? "")
                """)
            
            return data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error -> Error in
            log(.networkResponse,
                """
                🔴 Request: \(request.string)
                Error: \(error.localizedDescription)
                """)
            return error
        }
        .eraseToAnyPublisher()
    }
}
