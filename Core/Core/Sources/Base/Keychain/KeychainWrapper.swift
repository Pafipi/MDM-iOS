//
//  KeychainWrapper.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation
import KeychainAccess

public class KeychainWrapper {
    private static let sharedKeychain = Keychain()
    
    public static var deviceUUID: UUID? {
        get {
            guard let value = value(for: "deviceUUID") else { return nil }
            return UUID(uuidString: value)
        }
        set {
            sharedKeychain["deviceUUID"] = newValue?.uuidString
        }
    }
}

// MARK: - Private methods

private extension KeychainWrapper {
    
    static func store(value: String, for key: String) {
        sharedKeychain[key] = value
        log(.keychain, "Store value: \(value), for key: \(key)")
    }
    
    static func value(for key: String) -> String? {
        log(.keychain, "Retrieve value for key: \(key)")
        return sharedKeychain[key]
    }
}
