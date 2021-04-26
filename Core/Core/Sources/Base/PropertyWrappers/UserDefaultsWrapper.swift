//
//  UserDefaultsWrapper.swift
//  Core
//
//  Created by Piotr Fraccaro on 25/04/2021.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    public var wrappedValue: Value {
        get {
            log(.userDefaults, "Retrieve value for key: \(key) from UserDefaults")
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            log(.userDefaults, "Store value for key: \(key) in UserDefaults")
            container.set(newValue, forKey: key)
        }
    }
}

public extension UserDefaults {
    
    @UserDefault(key: "mdm_server_address", defaultValue: nil)
    static var mdmServerAddress: String?
}
