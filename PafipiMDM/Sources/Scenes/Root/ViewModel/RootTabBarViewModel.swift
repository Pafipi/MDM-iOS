//
//  RootTabBarViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import Foundation

protocol RootTabBarViewModel {
    var output: RootTabBarViewModelOutput? { get set }
}

protocol RootTabBarViewModelOutput: AnyObject {
    
}

final class RootTabBarViewModelImpl: RootTabBarViewModel {
    
    weak var output: RootTabBarViewModelOutput?
}
