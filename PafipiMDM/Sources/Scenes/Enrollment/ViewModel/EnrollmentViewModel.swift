//
//  EnrollmentViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver
import Core

protocol EnrollmentViewModel {
    var output: EnrollmentViewModelOutput? { get set }
    
    func viewDidLoad()
    func setEnrollmentAddress(_ address: String)
    func validateEnrollmentAddress()
}

protocol EnrollmentViewModelOutput: AnyObject {
    
    func onUrlValidationSuccess()
    func onUrlValidationError(with message: String)
}

final class EnrollmentViewModelImpl: EnrollmentViewModel {
 
    weak var output: EnrollmentViewModelOutput?
    
    @LazyInjected private var repository: EnrollmentRepository
    @LazyInjected private var urlValidator: URLValidator
    
    private var enrollmentAddress: String = "https://"
    
    func viewDidLoad() {
        repository.fetchUsers()
    }
    
    func setEnrollmentAddress(_ address: String) {
        enrollmentAddress = address
    }
    
    func validateEnrollmentAddress() {
        switch urlValidator.validate(enrollmentAddress) {
        case .invalid(let error):
            if let error = error as? ValidationError {
                output?.onUrlValidationError(with: getErrorMessage(for: error))
            }
        case .valid:
            output?.onUrlValidationSuccess()
        }
    }
}

// MARK: - Private methods

private  extension EnrollmentViewModelImpl {
    
    func getErrorMessage(for error: ValidationError) -> String {
        switch error {
        case .urlValidationError(let reason):
            switch reason {
            case .isEmpty:
                return LocalizedStrings.ValidationError.emptyField
            case .isNotURL:
                return LocalizedStrings.ValidationError.invalidURL
            }
        }
    }
}
