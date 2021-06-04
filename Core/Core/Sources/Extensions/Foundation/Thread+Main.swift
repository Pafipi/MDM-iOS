//
//  Thread+Main.swift
//  Core
//
//  Created by Piotr Fraccaro on 20/03/2021.
//

import Foundation

public typealias MainThreadBlock = () -> Void

public extension Thread {

    class func asyncOnMain(block: @escaping MainThreadBlock) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                block()
            }
        } else {
            block()
        }
    }
}
