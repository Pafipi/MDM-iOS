//
//  Endpoint.swift
//  Core
//
//  Created by Piotr Fraccaro on 12/04/2021.
//

import Foundation

public protocol Endpoint {
    
    var url: URL { get }
    var headers: Headers { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get set }
}
