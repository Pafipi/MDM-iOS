//
//  EnrollmentView.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Core

protocol EnrollmentViewDelegate: AnyObject {
    
}

final class EnrollmentView: UIView {
    
    weak var delegate: EnrollmentViewDelegate?
}
