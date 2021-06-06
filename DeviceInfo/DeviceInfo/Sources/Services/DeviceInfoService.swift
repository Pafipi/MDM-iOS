//
//  DeviceInfoService.swift
//  DeviceInfo
//
//  Created by Piotr Fraccaro on 06/06/2021.
//

import UIKit
import Combine
import Core
import Resolver

public protocol DeviceInfoService {
    
    func postDeviceInfo()
}

final class DeviceInfoServiceImpl: DeviceInfoService {
    
    @LazyInjected private var networking: DeviceInfoNetworking
    
    private var deviceUUID: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    func postDeviceInfo() {
        networking.postDeviceInfo(requestBody: getPostDeviceRequstBody())
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    log(.error, "Device info post request failed with error: \(error.localizedDescription)")
                case .finished:
                    log(.success, "Device info post request finished successfully")
                }
            }, receiveValue: { _ in })
            .store(in: &disposeBag)
    }
}

// MARK: - Private methods

private extension DeviceInfoServiceImpl {
    
    func getPostDeviceRequstBody() -> PostDeviceInfoRequestBody {
        let currentDevice = UIDevice.current
        return PostDeviceInfoRequestBody(
            deviceId: currentDevice.identifierForVendor?.uuidString ?? "",
            name: currentDevice.name,
            systemName: currentDevice.systemName,
            systemVersion: currentDevice.systemVersion,
            model: currentDevice.model
        )
    }
}
