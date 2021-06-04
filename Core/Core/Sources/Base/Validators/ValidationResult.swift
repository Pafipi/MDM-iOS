//
//  ValidationResult.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation

public enum ValidationResult {
    case valid
    case invalid(Error)
}

public enum ValidationError: Error {
    
    public enum URLValidationErrorReason {
        case isEmpty
        case isNotURL
    }
    
    case urlValidationError(_ reason: URLValidationErrorReason)
}

extension ValidationError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .urlValidationError(let reason):
            switch reason {
            case .isEmpty:
                return CoreLocalizations.fieldCannotBeEmpty
            case .isNotURL:
                return CoreLocalizations.invalidUrl
            }
        }
    }
}
