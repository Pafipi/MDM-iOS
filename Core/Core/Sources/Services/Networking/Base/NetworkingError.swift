//
//  NetworkingError.swift
//  Core
//
//  Created by Piotr Fraccaro on 15/04/2021.
//

import Foundation

public enum NetworkingError: Error {
    case invalidURL
    case invalidURLParameters
    case invalidJSONParameters
    case notHttpResponse
    case apiError(code: Int, data: Data?)
}

extension NetworkingError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidURLParameters:
            return "Invalid URL Params"
        case .invalidJSONParameters:
            return "Invalid JSON Params"
        case .notHttpResponse:
            return "Not HTTP Response"
        case .apiError(let code, let data):
            var description = "Api error: \(code);"
            guard let data = data,
                  let message = String(data: data, encoding: .utf8) else {
                return description
            }
            description += "\nError message: \(message);"
            return description
        }
    }
}
