//
//  BatteryInfoService.swift
//  BatteryInfo
//
//  Created by Piotr Fraccaro on 05/06/2021.
//

import UIKit
import Core
import Combine
import Resolver

public protocol BatteryInfoService {
    
    func updateBatteryLevel()
    func updateBatteryState()
}

final class BatteryInfoServiceImpl: BatteryInfoService {
    
    @LazyInjected private var networking: BatteryInfoNetworking
    
    private var deviceUUID: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        log(.debug, "Enable battery monitoring")
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func updateBatteryLevel() {
        guard let deviceUUID = deviceUUID else { return }
        let batteryLevel = UIDevice.current.batteryLevel
        networking.postBatteryLevel(level: batteryLevel, forDeviceWith: deviceUUID)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    log(.error, "Battery level post request failed with error: \(error.localizedDescription)")
                case .finished:
                    log(.success, "Battery level post request finished successfully")
                }
            }, receiveValue: { _ in })
            .store(in: &disposeBag)
    }
    
    func updateBatteryState() {
        guard let deviceUUID = deviceUUID else { return }
        let batteryState = UIDevice.current.batteryState
        networking.postBatteryState(state: batteryState.rawValue, forDeviceWith: deviceUUID)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.global(qos: .background))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    log(.error, "Battery state post request failed with error: \(error.localizedDescription)")
                case .finished:
                    log(.success, "Battery state post request finished successfully")
                }
            }, receiveValue: { _ in })
            .store(in: &disposeBag)
    }
}

// MARK: - Private methods

private extension BatteryInfoServiceImpl {
    
    func addObservers() {
        NotificationCenterHelper.shared.addObserver(
            observer: self,
            selector: #selector(onBatteryLevelDidChange),
            name: .batteryLevelDidChange
        )
        NotificationCenterHelper.shared.addObserver(
            observer: self,
            selector: #selector(onBatteryStateDidChange),
            name: .batteryStateDidChange
        )
    }
    
    func removeObservers() {
        NotificationCenterHelper.shared.removeObserver(observer: self, name: .batteryLevelDidChange)
        NotificationCenterHelper.shared.removeObserver(observer: self, name: .batteryStateDidChange)
    }
}

// MARK: - Selectors

private extension BatteryInfoServiceImpl {
    
    @objc func onBatteryLevelDidChange() {
        log(.debug, "Battery level did change")
        
        guard UserDefaults.isEnrolled else {
            log(.debug, "Battery level not updated cause device is not enrolled")
            return
        }
        
        updateBatteryLevel()
    }
    
    @objc func onBatteryStateDidChange() {
        log(.debug, "Battery state did change")
        
        guard UserDefaults.isEnrolled else {
            log(.debug, "Battery state not updated cause device is not enrolled")
            return
        }
        
        updateBatteryState()
    }
}
