//
//  HttpURLSessionDelegate.swift
//  Core
//
//  Created by Piotr Fraccaro on 20/04/2021.
//

import Foundation

public final class HttpURLSessionDelegate: NSObject { }

extension HttpURLSessionDelegate: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}
