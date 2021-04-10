//
//  CoordinableView.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import Foundation

// Type Alias to mark viewcontroller that are intended for the navigation controller stack
typealias StackableViewController = (CoordinableView)

protocol CoordinableView {
    
    var stackCoordinatorDelegate: StackCoordinable? { get set }
}
