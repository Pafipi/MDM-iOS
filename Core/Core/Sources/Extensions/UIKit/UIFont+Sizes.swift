//
//  UIFont+Sizes.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public extension UIFont {
    enum Sizes {
        /// 11
        case theSmallest
        /// 12
        case smallest
        /// 13
        case smaller
        /// 14
        case small
        /// 15
        case mediumSmall
        /// 16
        case medium
        /// 17
        case mediumLarge
        /// 18
        case large
        /// 20
        case larger
        /// 22
        case largest
        case custom(size: CGFloat)
    }
    
    class func regularMainStyleFont(ofSize size: Sizes) -> UIFont {
        UIFont(name: "Lato-Regular", size: size.value) ?? .systemFont(ofSize: size.value, weight: .regular)
    }
    
    class func boldMainStyleFont(ofSize size: Sizes) -> UIFont {
        UIFont(name: "Lato-Bold", size: size.value) ?? .systemFont(ofSize: size.value, weight: .bold)
    }

    class func heavyMainStyleFont(ofSize size: Sizes) -> UIFont {
        UIFont(name: "Lato-Black", size: size.value) ?? .systemFont(ofSize: size.value, weight: .heavy)
    }
    
    class func lightMainStyleFont(ofSize size: Sizes) -> UIFont {
        UIFont(name: "Lato-Light", size: size.value) ?? .systemFont(ofSize: size.value, weight: .light)
    }

    class func extraLightMainStyleFont(ofSize size: Sizes) -> UIFont {
        UIFont(name: "Lato-Hairline", size: size.value) ?? .systemFont(ofSize: size.value, weight: .ultraLight)
    }
}

extension UIFont.Sizes {
    var value: CGFloat {
        switch self {
        case .theSmallest:
            return 11.0
        case .smallest:
            return 12.0
        case .smaller:
            return 13.0
        case .small:
            return 14.0
        case .mediumSmall:
            return 15.0
        case .medium:
            return 16.0
        case .mediumLarge:
            return 17.0
        case .large:
            return 18.0
        case .larger:
            return 20.0
        case .largest:
            return 22.0
        case .custom(let size):
            return size
        }
    }
}
