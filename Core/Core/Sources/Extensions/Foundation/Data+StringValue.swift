//
//  Data+StringValue.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation

public extension Data {
  
    var stringValue: String? {
        String(data: self, encoding: .utf8)
    }
    
    var prettyStringValue: NSString? {
        if let dictionaryValue = try? JSONSerialization.jsonObject(with: self, options: .allowFragments),
            let dataValue = try? JSONSerialization.data(withJSONObject: dictionaryValue, options: .prettyPrinted),
            let stringValue = dataValue.stringValue {
            return stringValue as NSString
        }
        guard let stringValue = stringValue else { return nil }
        return stringValue as NSString
    }
    
}
