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
            store(value: newValue?.uuidString, for: "deviceUUID")
        }
    }
    
    public static var mdmServerAddress: String? {
        get {
            guard let value = value(for: "mdmServerAddress") else { return "" }
            return value
        }
        set {
           store(value: newValue, for: "mdmServerAddress")
        }
    }
}

// MARK: - Private methods

private extension KeychainWrapper {
    
    static func store(value: String?, for key: String) {
        DispatchQueue.global(qos: .background).async {
            sharedKeychain[key] = value
            log(.keychain, "Store value for key: \(key)")
        }
    }
    
    static func value(for key: String) -> String? {
        log(.keychain, "Retrieve value for key: \(key)")
        return sharedKeychain[key]
    }
}
