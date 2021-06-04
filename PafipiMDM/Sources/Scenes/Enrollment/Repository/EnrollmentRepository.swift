//
//  EnrollmentRepository.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Combine
import Resolver
import Core

protocol EnrollmentRepository {
    var delegate: EnrollmentRepositoryDelegate? { get set }
    
    func fetchDeviceUUID(with deviceId: String)
    func putDeviceToken(_ deviceToken: String, forDeviceWith deviceId: String)
    func requestEnrollmentPush(forDeviceWith deviceId: String)
}

protocol EnrollmentRepositoryDelegate: AnyObject {
 
    func onGetDeviceUUIDSuccess(with uuid: String)
    func onGetDeviceUUIDFailure(with error: Error)
    func onPutDeviceTokenSuccess()
    func onPutDeviceTokenFailure(with error: Error)
    func onRequestEnrollmentPushSuccess()
    func onRequestEnrollmentPushFailure(with error: Error)
}

final class EnrollmentRepositoryImpl: EnrollmentRepository {
    
    weak var delegate: EnrollmentRepositoryDelegate?
    
    @LazyInjected private var deviceNetworking: DeviceNetworking
    @LazyInjected private var enrollmentNetworking: EnrollmentNetworking
    
    private var disposeBag = Set<AnyCancellable>()
    
    func fetchDeviceUUID(with deviceId: String) {
        deviceNetworking.fetchDeviceUUID(with: deviceId)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.delegate?.onGetDeviceUUIDFailure(with: error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] deviceUUID in
                guard let self = self else { return }
                self.delegate?.onGetDeviceUUIDSuccess(with: deviceUUID)
            })
            .store(in: &disposeBag)
    }
    
    func putDeviceToken(_ deviceToken: String, forDeviceWith deviceId: String) {
        deviceNetworking.putDeviceToken(deviceToken, forDeviceWith: deviceId)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.delegate?.onPutDeviceTokenFailure(with: error)
                case .finished:
                    self.delegate?.onPutDeviceTokenSuccess()
                }
            }, receiveValue: { _ in })
            .store(in: &disposeBag)
    }
    
    func requestEnrollmentPush(forDeviceWith deviceId: String) {
        enrollmentNetworking.requestEnrollmentPush(for: deviceId)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.delegate?.onRequestEnrollmentPushFailure(with: error)
                case .finished:
                    self?.delegate?.onRequestEnrollmentPushSuccess()
                }
            }, receiveValue: { _ in })
            .store(in: &disposeBag)
    }
}
