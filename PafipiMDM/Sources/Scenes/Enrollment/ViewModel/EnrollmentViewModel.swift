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
    
    func startEnrollment() {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            return
            
        }
        KeychainWrapper.mdmServerAddress = enrollmentAddress
        repository.fetchDeviceUUID(with: deviceId)
    }
}

// MARK: - EnrollmentRepositoryDelegate

extension EnrollmentViewModelImpl: EnrollmentRepositoryDelegate {

    func onGetDeviceUUIDSuccess(with uuid: String) {
//        repository.putDeviceToken(forDeviceWith: <#T##String#>, deviceToken: <#T##String#>)
    }
    
    func onGetDeviceUUIDFailure(with error: Error) {
        
    }
    
    func onPutDeviceTokenSuccess() {
        
    }
    
    func onPutDeviceTokenFailure(with error: Error) {
        
    }
}

// MARK: - Private methods

private extension EnrollmentViewModelImpl {
    
    func getErrorMessage(for error: ValidationError) -> String {
        switch error {
        case .urlValidationError(let reason):
            switch reason {
            case .isEmpty:
                return L10n.fieldCannotBeEmpty
            case .isNotURL:
                return L10n.invalidUrl
            }
        }
    }
}
