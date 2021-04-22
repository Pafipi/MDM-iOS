//
//  TextField.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public typealias TextFieldClosure = ((TextField) -> Void)

public final class TextField: UITextField {
    
    public var didBeginEditing: TextFieldClosure?
    public var didChangeContent: TextFieldClosure?
    public var didEndEditing: TextFieldClosure?
    
    private var contentChangeDebouncer: Debouncer?
    private var placeholderColor: UIColor = .darkGray
    
    public init(text: String = "",
                placeholder: String = "",
                font: UIFont = .regularMainStyleFont(ofSize: .medium),
                cornerRadius: CGFloat = 0.0,
                alignment: NSTextAlignment = .left,
                returnButtonType: UIReturnKeyType = .done,
                autocapitalizationType: UITextAutocapitalizationType = .sentences,
                autocorrectionType: UITextAutocorrectionType = .no,
                textColor: UIColor = .black,
                placeholderColor: UIColor = .darkGray,
                backgroundColor: UIColor = .white,
                borderWidth: CGFloat = 0.0,
                borderColor: UIColor = .black,
                debounceContentChange: Bool = false,
                accessibilityIdentifier: String? = "",
                accessibilityLabel: String? = "") {
        super.init(frame: .zero)
        self.font = font
        self.textAlignment = alignment
        self.returnKeyType = returnButtonType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textColor = textColor
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityLabel = accessibilityLabel
        self.backgroundColor = backgroundColor
        self.placeholderColor = placeholderColor
        setPlaceholder(placeholder: placeholder)
        setText(text: text)
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        delegate = self
        
        if debounceContentChange {
            contentChangeDebouncer = Debouncer(
                delay: Constants.TimeIntervals.contentChangeDebounceDelay
            ) { [weak self] in
                guard let self = self else { return }
                self.didChangeContent?(self)
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.ContentInsets.textField)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.ContentInsets.textField)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.ContentInsets.textField)
    }
    
    func setText(text: String?) {
        guard let text = text else { return }
        self.text = text
    }
    
    func setPlaceholder(placeholder: String?) {
        guard let placeholder = placeholder else { return }
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: placeholderColor,
                                                         .font: UIFont.lightMainStyleFont(ofSize: .medium)]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    func setBorderWidth(_ width: CGFloat?) {
        UIView.animate(withDuration: Constants.TimeIntervals.borderWidthChange) { [weak self] in
            self?.layer.borderWidth = width ?? 0.0
        }
    }
    
    func setBorderColor(_ color: UIColor) {
        UIView.animate(withDuration: Constants.TimeIntervals.borderColorChange) { [weak self] in
            self?.layer.borderColor = color.cgColor
        }
    }
}

// MARK: - UITextFieldDelegate

extension TextField: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing?(self)
    }
    
    public func textFieldDidChangeContent(_ textField: UITextField) {
        if let debouncer = contentChangeDebouncer {
            debouncer.call()
        } else {
            didChangeContent?(self)
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard reason == .committed else { return }
        didEndEditing?(self)
    }
}

// MARK: - Constants

private struct Constants {
    
    struct ContentInsets {
        static let textField: UIEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: 8)
    }
    
    struct TimeIntervals {
        static let borderWidthChange: TimeInterval = 0.2
        static let borderColorChange: TimeInterval = 0.2
        static let contentChangeDebounceDelay: TimeInterval = 1.0
    }
}
