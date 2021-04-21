//
//  EnrollmentError.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 21/04/2021.
//

import Foundation

enum EnrollmentError: Error {
    
    case invalidGivenURL
    case internalServerError
    case networkNotReachable
    case deviceNotRegisteredForPushNotifications
}
