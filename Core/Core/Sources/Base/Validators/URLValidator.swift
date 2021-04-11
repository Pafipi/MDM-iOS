//
//  URLValidator.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation

public protocol URLValidator {
    func validate(_ string: String) -> ValidationResult
}

public final class URLValidatorImpl: URLValidator {
    
    public func validate(_ string: String) -> ValidationResult {
        guard !string.isEmpty else {
            return .invalid(ValidationError.urlValidationError(.isEmpty))
        }
        guard string.isValidURL else {
            return .invalid(ValidationError.urlValidationError(.isNotURL))
        }
        return .valid
    }
}
