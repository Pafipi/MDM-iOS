//
//  RootTabBarViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import Foundation
import Resolver
import BatteryInfo

protocol RootTabBarViewModel {
    var output: RootTabBarViewModelOutput? { get set }
}

protocol RootTabBarViewModelOutput: AnyObject {
    
}

final class RootTabBarViewModelImpl: RootTabBarViewModel {
    
    @Injected private var batteryService: BatteryService
    
    weak var output: RootTabBarViewModelOutput?
}
