//
//  EnrollmentViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Resolver
import Core

protocol EnrollmentViewModel {
    var output: EnrollmentViewModelOutput? { get set }
    
    func getEnrollmentAddress() -> String
    func setEnrollmentAddress(_ address: String)
    func setDeviceToken(_ token: Data?)
    func validateEnrollmentAddress()
    func startEnrollment()
}

protocol EnrollmentViewModelOutput: AnyObject {
    
    func onUrlValidationSuccess()
    func onUrlValidationError(with message: String)
    func onEnrollmentError(with message: String)
}

final class EnrollmentViewModelImpl: EnrollmentViewModel {
 
    weak var output: EnrollmentViewModelOutput?
    
    @LazyInjected private var repository: EnrollmentRepository
    @LazyInjected private var urlValidator: URLValidator
    
    private var enrollmentAddress: String = "192.168.1.66"
    private var deviceToken: Data?
    private var deviceID: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    init() {
        repository.delegate = self
    }
    
    func getEnrollmentAddress() -> String {
        enrollmentAddress
    }
    
    func setEnrollmentAddress(_ address: String) {
        enrollmentAddress = address
    }
    
    func setDeviceToken(_ token: Data?) {
        deviceToken = token
    }

    func validateEnrollmentAddress() {
        switch urlValidator.validate(enrollmentAddress) {
        case .invalid(let error):
            if let error = error as? ValidationError {
                output?.onUrlValidationError(with: error.localizedDescription)
            }
        case .valid:
            output?.onUrlValidationSuccess()
        }
    }
    
    func startEnrollment() {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        UserDefaults.mdmServerAddress = enrollmentAddress
        repository.fetchDeviceUUID(with: deviceId)
    }
}

// MARK: - EnrollmentRepositoryDelegate

extension EnrollmentViewModelImpl: EnrollmentRepositoryDelegate {

    func onGetDeviceUUIDSuccess(with uuid: String) {
        guard let deviceToken = deviceToken else {
            return
        }
//        UserDefaults.deviceUUID = uuid
        
        guard let deviceId = deviceID else {
            return
        }
        repository.putDeviceToken(deviceToken, forDeviceWith: deviceId)
    }
    
    func onGetDeviceUUIDFailure(with error: Error) {
        
    }
    
    func onPutDeviceTokenSuccess() {
        
    }
    
    func onPutDeviceTokenFailure(with error: Error) {
        
    }
}
