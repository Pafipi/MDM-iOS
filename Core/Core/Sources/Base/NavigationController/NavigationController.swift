//
//  NavigationController.swift
//  Core
//
//  Created by Piotr Fraccaro on 25/03/2021.
//

import UIKit

public class NavigationController: UINavigationController {
    
    private var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    
    public func changeStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
    }
    
    public func resetStatusBarStyle() {
        statusBarStyle = .default
    }
}
