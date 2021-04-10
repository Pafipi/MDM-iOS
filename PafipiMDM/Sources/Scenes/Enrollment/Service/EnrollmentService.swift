//
//  EnrollmentService.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver

protocol EnrollmentService {
    var delegate: EnrollmentServiceDelegate? { get set }
}

protocol EnrollmentServiceDelegate: AnyObject {
    
}

final class EnrollmentServiceImpl: EnrollmentService {
 
    weak var delegate: EnrollmentServiceDelegate?
    
    @LazyInjected private var repository: EnrollmentRepository
}
