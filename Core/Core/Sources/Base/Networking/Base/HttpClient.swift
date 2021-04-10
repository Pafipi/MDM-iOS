//
//  HttpClient.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation

struct InvalidURL: Error {}
struct InvalidURLParameters: Error {}
struct NotHttpResponse: Error {}
struct APIError: Error {
    let code: Int
    let data: Data?
}

typealias Completion<T> = (T) -> Void

final class HttpClient {
    
    static let shared = HttpClient()
    
    func perform<T: Codable>(_ request: HttpRequest<T>) {
        
        log(.network, "↑ \(request.string)")
        
        guard var components = URLComponents(string: request.url) else {
            callCompletion(request: request, data: nil, result: .failure(InvalidURL()))
            return
        }
        
        if request.method == .get {
            components.queryItems = components.queryItems != nil ? components.queryItems : [URLQueryItem]()
            components.queryItems?.append(contentsOf: request.parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") })
        }
        
        guard let url = components.url else {
            callCompletion(request: request, data: nil, result: .failure(InvalidURLParameters()))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers.dictionary
        
        if request.method != .get {
            let data = try? JSONSerialization.data(withJSONObject: request.parameters, options: [])
            urlRequest.httpBody = data
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            self.serializeResponse(request: request, data: data, response: response, error: error)
        }
        .resume()
        
    }
    
}

private extension HttpClient {
    
    private func callCompletion<T: Codable>(request: HttpRequest<T>, data: Data?, result: Result<T, Error>) {
        if case .failure(let error) = result {
            log(.error, """
                ↓ \(request.string)
                Error: \(error.localizedDescription)
                Response: \(data?.prettyStringValue ?? "")
                """)
        }
        log(.success, """
            ↓ \(request.string)
            Response: \(data?.prettyStringValue ?? "")
            """)
        
        request.completion?(result)
    }
    
    private func serializeResponse<T: Codable>(request: HttpRequest<T>, data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            callCompletion(request: request, data: data, result: .failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            callCompletion(request: request, data: data, result: .failure(NotHttpResponse()))
            return
        }
        
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            callCompletion(request: request, data: data, result: .failure(APIError(code: httpResponse.statusCode, data: data)))
            return
        }
        
        if let dataAsCodable = data as? T {
            callCompletion(request: request, data: data, result: .success(dataAsCodable))
            return
        }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: data ?? Data())
            callCompletion(request: request, data: data, result: .success(object))
        } catch let error {
            callCompletion(request: request, data: data, result: .failure(error))
        }
    }
}
