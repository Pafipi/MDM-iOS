//
//  UIView+FillSuperview.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public extension UIView {
    
    func fillSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
