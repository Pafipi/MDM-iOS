//
//  String+ValidURL.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation

public extension String {
    
    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
     }
}
