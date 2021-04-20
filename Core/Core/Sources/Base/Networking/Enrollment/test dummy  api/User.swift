//
//  User.swift
//  Core
//
//  Created by Piotr Fraccaro on 16/04/2021.
//

import Foundation

public struct Users: Codable {
    let data: [User]?
}

public struct User: Codable {
    let id: String?
    let title: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let picture: String?
}
