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
    case invalidEmptyResponse
    case apiError(code: Int, data: Data?)
}

extension NetworkingError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "todo"
        case .invalidURLParameters:
            return "todo"
        case .invalidJSONParameters:
            return "todo"
        case .notHttpResponse:
            return "todo"
        case .invalidEmptyResponse:
            return "todo"
        case .apiError(let code, let data):
            return "todo"
        }
    }
}
