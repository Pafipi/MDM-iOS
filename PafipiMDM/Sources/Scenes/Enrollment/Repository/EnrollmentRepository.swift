//
//  EnrollmentRepository.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Resolver
import Core

protocol EnrollmentRepository {
    
}

final class EnrollmentRepositoryImpl: EnrollmentRepository {
    
    @LazyInjected private var networking: EnrollmentNetworking
}
