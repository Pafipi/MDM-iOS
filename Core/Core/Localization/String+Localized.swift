//
//  String+Localized.swift
//  Core
//
//  Created by Piotr Fraccaro on 21/03/2021.
//

import Foundation

public extension String {
    
    /// Get the localized string from a specific module (Defaults to Core)
    /// - Parameters:
    ///   - bundle: The bundle to get localization from
    ///   - comment: The comment to attach to the localization,
    /// - Returns: The localized string within the bundle
    func localized(in bundle: BundleType = .core, comment: String? = nil) -> String {
        guard let bundle = Bundle(identifier: bundle.rawValue) else { return self }
        return NSLocalizedString(self, bundle: bundle, comment: comment ?? "")
    }
    
    func localize(in bundle: BundleType = .core, comment: String? = nil, arguments: CVarArg...) -> String {
        return String(format: self.localized(in: bundle, comment: comment), arguments: arguments)
    }
}
