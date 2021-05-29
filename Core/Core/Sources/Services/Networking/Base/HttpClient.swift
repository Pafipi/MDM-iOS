//
//  HttpClient.swift
//  IteoTemplate
//
//  Created by Piotr Fraccaro on 19/04/2021.
//

import Foundation
import Combine

public typealias NetworkingResultPublisher<R: Codable> = AnyPublisher<R, Error>

public struct EmptyResponse: Codable { }

protocol HttpClient: AnyObject {
    
    func perform<T: Codable, R: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<R>
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
    
    func perform<T: Codable, R: Codable>(_ request: HttpRequest<T>) -> NetworkingResultPublisher<R> {
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
        
        if request.method != .get && request.body != nil {
            guard
                let data = try? JSONEncoder().encode(request.body)
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
    
    func networkingResultPublisher<T: Codable, R: Codable>(for request: HttpRequest<T>) -> NetworkingResultPublisher<R> {
        tryMap { data, response -> Data in
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
        .compactMap { data -> R? in
            if R.self == EmptyResponse.self,
               let empty = EmptyResponse() as? R {
                return empty
            }
            
            let decoder = JSONDecoder()
            return try? decoder.decode(R.self, from: data)
        }
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
