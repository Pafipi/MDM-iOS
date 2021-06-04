//
//  Button.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import UIKit

public typealias ButtonHandler = (() -> Void)

public class Button: UIView {
    
    public let base = UIButton(type: .system)
    
    public var isSelected: Bool {
        get {
            return base.isSelected
        }
        set {
            base.isSelected = newValue
        }
    }
    
    private var buttonBackgroundColor: UIColor?
    private var buttonDisabledBackgroundColor: UIColor?
    private var buttonHandler: ButtonHandler?
    
    public init(title: String,
                font: UIFont,
                tintColor: UIColor = .blue,
                textColor: UIColor = .white,
                backgroundColor: UIColor = .blue,
                disabledColor: UIColor = .lightGray,
                cornerRadius: CGFloat = 0,
                contentInsets: UIEdgeInsets = .zero,
                textAlignment: NSTextAlignment = .natural,
                image: UIImage? = nil,
                borderWidth: CGFloat = .zero,
                borderColor: CGColor? = nil,
                accessibilityIdentifier: String,
                accessibilityLabel: String) {
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        base.translatesAutoresizingMaskIntoConstraints = false
        base.accessibilityLabel = accessibilityLabel
        base.accessibilityIdentifier = accessibilityIdentifier
        base.setTitle(title, for: .normal)
        base.titleLabel?.textAlignment = textAlignment
        base.titleLabel?.font = font
        base.tintColor = tintColor
        base.backgroundColor = backgroundColor
        
        base.layer.cornerRadius = cornerRadius
        base.layer.masksToBounds = true
        base.contentEdgeInsets = contentInsets
        base.titleLabel?.adjustsFontSizeToFitWidth = true
        base.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        base.setImage(image, for: .normal)
        base.imageView?.contentMode = .scaleAspectFit
        base.layer.borderWidth = borderWidth
        base.layer.borderColor = borderColor
        base.titleLabel?.textColor = textColor
        
        buttonBackgroundColor = backgroundColor
        buttonDisabledBackgroundColor = disabledColor
        addSubview(base)
        base.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func handleTap() {
        buttonHandler?()
    }
    
    public func didTap(_ handler: @escaping ButtonHandler) {
        buttonHandler = handler
    }

    public var isEnabled: Bool {
        get { return base.isEnabled }
        set { base.isEnabled = newValue }
    }

    public func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        base.setBackgroundImage(image, for: state)
    }
    
    public func setBackgroundColor(_ color: UIColor?) {
        base.backgroundColor = color
    }
    
    public func setUserInteractionEnabled(_ enabled: Bool) {
        base.isUserInteractionEnabled = enabled
        base.backgroundColor = enabled ? buttonBackgroundColor : buttonDisabledBackgroundColor
    }

    public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        base.setTitleColor(color, for: state)
    }

    public func setTitle(_ title: String?, for state: UIControl.State) {
        base.setTitle(title, for: state)
        base.accessibilityLabel = title
    }
    
    public func setAttributedTextTitle(_ title: NSAttributedString?) {
        base.setAttributedTitle(title, for: .normal)
        base.setAttributedTitle(title, for: .disabled)
        base.accessibilityLabel = title?.string
    }
    
    public func setImage(_ image: UIImage?, for state: UIControl.State) {
        base.setImage(image, for: state)
    }

    public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        base.addTarget(target, action: action, for: controlEvents)
    }
    
    public func setNumberOfLines(to value: Int) {
        base.titleLabel?.numberOfLines = value
    }
}
