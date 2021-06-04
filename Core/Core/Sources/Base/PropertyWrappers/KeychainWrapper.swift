//
//  KeychainWrapper.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation
import KeychainAccess

@propertyWrapper
public struct KeychainValue {
    let key: String
    let defaultValue: String?
    var container = Keychain()

    public var wrappedValue: String? {
        get {
            log(.keychain, "Retrieve value for key: \(key)")
            return container[key]
        }
        set {
            log(.keychain, "Store value for key: \(key)")
            container[key] = newValue
        }
    }
}

public class KeychainWrapper {

    @KeychainValue(key: "deviceUUID", defaultValue: nil)
    public static var deviceUUID: String?
}
