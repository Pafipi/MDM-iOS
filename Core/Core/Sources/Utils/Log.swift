//
//  Log.swift
//  Core
//
//  Created by Piotr Fraccaro on 21/03/2021.
//

import Foundation

public enum LogIcon: String {
    case save = "[💾]"
    case push = "[📲]"
    case network = "[🌐]"
    case event = "[🔔]"
    case debug = "[⚙️]"
    case info = "[ℹ️]"
    case success = "[✅]"
    case warning = "[⚠️]"
    case error = "[❌]"
}

public func log(_ icon: LogIcon, _ args: Any) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss.SSS"
    print("\(dateFormatter.string(from: Date())) \(icon.rawValue) \(args)")
}
