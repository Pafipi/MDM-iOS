//
//  Data+HexString.swift
//  Core
//
//  Created by Piotr Fraccaro on 30/05/2021.
//

import Foundation

public extension Data {
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
