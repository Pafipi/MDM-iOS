//
//  UIView+Anchor.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public extension UIView {
    
    func anchor(centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                constant: (x: CGFloat?, y: CGFloat?)? = nil,
                size: CGSize? = nil) {
        let constraints: [NSLayoutConstraint?] = [
            getCenterXConstraint(to: centerX, constant: constant?.x),
            getCenterYConstraint(to: centerY, constant: constant?.y),
            getHeightContraint(equalTo: size?.height),
            getWidthContraint(equalTo: size?.width)
        ]
        let mappedConstraints = constraints.compactMap { $0 }
        NSLayoutConstraint.activate(mappedConstraints)
    }
    
    func anchor(leading: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                padding: UIEdgeInsets? = nil,
                size: CGSize? = nil) {
        let constraints: [NSLayoutConstraint?] = [
            getLeadingConstraint(to: leading, constant: padding?.left),
            getTrailingConstraint(to: trailing, constant: padding?.right),
            getTopConstraint(to: top, constant: padding?.top),
            getBottomConstraint(to: bottom, constant: padding?.bottom),
            getHeightContraint(equalTo: size?.height),
            getWidthContraint(equalTo: size?.width)
        ]
        let mappedConstraints = constraints.compactMap { $0 }
        NSLayoutConstraint.activate(mappedConstraints)
    }
}

private extension UIView {
    
    
    func getLeadingConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.leadingAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }
    
    func getTrailingConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                               constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.trailingAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }

    func getTopConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                          constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.topAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }

    func getBottomConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                             constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.bottomAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }
    
    func getHeightContraint(equalTo constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let constant = constant else { return nil }
        return self.heightAnchor.constraint(equalTo: self.heightAnchor, constant: constant)
    }
    
    func getWidthContraint(equalTo constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let constant = constant else { return nil }
        return self.widthAnchor.constraint(equalTo: self.widthAnchor, constant: constant)
    }
    
    func getCenterXConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.centerXAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }
    
    func getCenterYConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor else { return nil }
        return self.centerYAnchor.constraint(equalTo: anchor, constant: constant ?? .zero)
    }
}
