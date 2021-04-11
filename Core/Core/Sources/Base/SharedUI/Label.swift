//
//  Label.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import UIKit

public final class Label: UILabel {

    public init(text: String,
                textStyle: UIFont.TextStyle = .body,
                alignment: NSTextAlignment = .center,
                color: UIColor? = nil,
                backgroundColor: UIColor? = .clear,
                accessibilityLabel: String,
                accessibilityIdentifier: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.isAccessibilityElement = true
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityIdentifier = accessibilityIdentifier
        self.text = text
        self.font = .preferredFont(forTextStyle: textStyle)
        self.textAlignment = alignment
        self.textColor = color
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0
        adjustsFontForContentSizeCategory = true
        
    }

    public init(text: String,
                font: UIFont,
                alignment: NSTextAlignment = .center,
                color: UIColor? = nil,
                backgroundColor: UIColor? = .clear,
                accessibilityLabel: String,
                accessibilityIdentifier: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.isAccessibilityElement = true
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityIdentifier = accessibilityIdentifier
        self.text = text
        self.font = font
        self.textAlignment = alignment
        self.textColor = color
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0
        adjustsFontForContentSizeCategory = true
    }
    
    public init(attributedText: NSAttributedString,
                textStyle: UIFont.TextStyle = .body,
                alignment: NSTextAlignment = .center,
                color: UIColor? = nil,
                backgroundColor: UIColor? = .clear,
                accessibilityLabel: String,
                accessibilityIdentifier: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.isAccessibilityElement = true
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityIdentifier = accessibilityIdentifier
        self.attributedText = attributedText
        self.textAlignment = alignment
        if color != nil {
        self.textColor = color
        }
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0
        adjustsFontForContentSizeCategory = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
