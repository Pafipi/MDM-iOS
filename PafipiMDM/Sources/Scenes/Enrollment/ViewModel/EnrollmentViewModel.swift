//
//  EnrollmentViewModel.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver

protocol EnrollmentViewModel {
    var output: EnrollmentViewModelOutput? { get set }
}

protocol EnrollmentViewModelOutput: AnyObject {
    
}

final class EnrollmentViewModelImpl: EnrollmentViewModel {
 
    weak var output: EnrollmentViewModelOutput?
    
    @LazyInjected private var service: EnrollmentService
}
