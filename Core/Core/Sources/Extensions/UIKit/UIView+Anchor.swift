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
        self.translatesAutoresizingMaskIntoConstraints = false
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
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    func aspectRatio(_ ratio: CGFloat) {
        widthAnchor
            .constraint(equalTo: heightAnchor, multiplier: ratio)
            .isActive = true
    }
}

private extension UIView {
    
    func getLeadingConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.leadingAnchor.constraint(equalTo: anchor, constant: constant ?? 0.0)
    }
    
    func getTrailingConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                               constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.trailingAnchor.constraint(equalTo: anchor, constant: -(constant ?? 0.0))
    }

    func getTopConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                          constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.topAnchor.constraint(equalTo: anchor, constant: constant ?? 0.0)
    }

    func getBottomConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                             constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.bottomAnchor.constraint(equalTo: anchor, constant: -(constant ?? 0.0))
    }
    
    func getHeightContraint(equalTo constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let constant = constant, constant != .zero else { return nil }
        return self.heightAnchor.constraint(equalToConstant: constant)
    }
    
    func getWidthContraint(equalTo constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let constant = constant, constant != .zero else { return nil }
        return self.widthAnchor.constraint(equalToConstant: constant)
    }
    
    func getCenterXConstraint(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.centerXAnchor.constraint(equalTo: anchor, constant: constant ?? 0.0)
    }
    
    func getCenterYConstraint(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                              constant: CGFloat? = .zero) -> NSLayoutConstraint? {
        guard let anchor = anchor, constant != .zero else { return nil }
        return self.centerYAnchor.constraint(equalTo: anchor, constant: constant ?? 0.0)
    }
}
