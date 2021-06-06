//
//  RootTabBarViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import Foundation
import Resolver
import BatteryInfo
import DeviceInfo

protocol RootTabBarViewModel {
    var output: RootTabBarViewModelOutput? { get set }
    
    func onViewDidLoad()
}

protocol RootTabBarViewModelOutput: AnyObject {
    
}

final class RootTabBarViewModelImpl: RootTabBarViewModel {
    
    @Injected private var batteryInfoService: BatteryInfoService
    @Injected private var deviceInfoService: DeviceInfoService
    
    weak var output: RootTabBarViewModelOutput?
    
    func onViewDidLoad() {
        deviceInfoService.postDeviceInfo()
    }
}
