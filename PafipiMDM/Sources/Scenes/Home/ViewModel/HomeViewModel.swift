//
//  HomeViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation

protocol HomeViewModel {
    var output: HomeViewModelOutput? { get set }
}

protocol HomeViewModelOutput: AnyObject {
    
}

final class HomeViewModelImpl: HomeViewModel {
    
    weak var output: HomeViewModelOutput?
}
