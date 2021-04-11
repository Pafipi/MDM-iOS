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
            guard let uuidString = sharedKeychain["deviceUUID"] else { return nil }
            return UUID(uuidString: uuidString)
        }
        set {
            sharedKeychain["deviceUUID"] = newValue?.uuidString
        }
    }
}
