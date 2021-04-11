//
//  Enrollment+Injection.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation
import Resolver

internal extension Resolver {
    
    static func registerEnrollmentServices() {
        registerEnrollmentScene()
    }
}

private extension Resolver {

    static func registerEnrollmentScene() {
        register { EnrollmentRepositoryImpl() as EnrollmentRepository }
        register { EnrollmentServiceImpl() as EnrollmentService }
        register { EnrollmentViewModelImpl() as EnrollmentViewModel }
    }
}
