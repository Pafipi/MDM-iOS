//
//  FatalErrorUtil.swift
//  Core
//
//  https://medium.com/@marcosantadev/how-to-test-fatalerror-in-swift-e1be9ff11a29
//

import Foundation

public func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

public struct FatalErrorUtil {

    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }

    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
