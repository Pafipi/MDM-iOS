//
//  Debouncer.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import Foundation

public class Debouncer: NSObject {
    
    public weak var timer: Timer?
    
    private let callback: (() -> Void)
    private let delay: Double
 
    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
 
    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay,
                                             target: self,
                                             selector: #selector(Debouncer.fireNow),
                                             userInfo: nil,
                                             repeats: false)
        timer = nextTimer
    }
 
    @objc func fireNow() {
        self.callback()
        timer?.invalidate()
        timer = nil
    }
}
