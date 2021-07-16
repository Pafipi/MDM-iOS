//
//  RootTabBarViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import Foundation
import Resolver
import Core

protocol RootTabBarViewModel {
    var output: RootTabBarViewModelOutput? { get set }
    
    func onViewDidLoad()
}

protocol RootTabBarViewModelOutput: AnyObject {
    
}

final class RootTabBarViewModelImpl: RootTabBarViewModel {
    
    weak var output: RootTabBarViewModelOutput?
    
    func onViewDidLoad() {}
}
