//
//  TextField.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public typealias TextFieldClosure = ((TextField) -> Void)

public final class TextField: UITextField {
    
    var didBeginEditing: TextFieldClosure?
    var didChangeContent: TextFieldClosure?
    var didEndEditing: TextFieldClosure?
    
    public init(text: String? = "",
                placeholder: String? = "",
                font: UIFont? = .regularMainStyleFont(ofSize: .medium),
                alignment: NSTextAlignment = .left,
                returnButtonType: UIReturnKeyType = .done,
                textColor: UIColor? = .black,
                placeholderColor: UIColor? = .darkGray,
                accessibilityIdentifier: String? = "",
                accessibilityLabel: String? = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setPlaceholder(placeholder: placeholder)
        setText(text: text)
        self.font = font
        self.textAlignment = alignment
        self.returnKeyType = returnButtonType
        self.textColor = textColor
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityLabel = accessibilityLabel
        backgroundColor = Colors.Form.inputBackground
        layer.borderWidth = Constants.Border.deselectedWidth
        layer.borderColor = Constants.Border.color
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        delegate = self
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
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: Colors.Common.placeholder,
                                                         .font: UIFont.extraLightMainStyleFont(ofSize: .medium)]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    func setBorderWidth(_ width: CGFloat?) {
        UIView.animate(withDuration: Constants.TimeIntervals.borderWidthChange) { [weak self] in
            self?.layer.borderWidth = width ?? 0.0
        }
    }
    
    func setBorderColor(_ color: UIColor?) {
        UIView.animate(withDuration: Constants.TimeIntervals.borderColorChange) { [weak self] in
            self?.layer.borderColor = (color ?? Colors.Common.tint).cgColor
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
        setBorderWidth(Constants.Border.selectedWidth)
        didBeginEditing?(self)
    }
    
    public func textFieldDidChangeContent(_ textField: UITextField) {
        didChangeContent?(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        setBorderWidth(Constants.Border.deselectedWidth)
        guard reason == .committed else { return }
        didEndEditing?(self)
    }
}

// MARK: - Constants

private struct Constants {
    
    struct ContentInsets {
        static let textField: UIEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: 8)
    }
    
    struct Border {
        static let deselectedWidth: CGFloat = 1.0
        static let selectedWidth: CGFloat = 2.0
        static let color: CGColor = Colors.Common.tint.cgColor
    }
    
    struct TimeIntervals {
        static let borderWidthChange: TimeInterval = 0.2
        static let borderColorChange: TimeInterval = 0.2
    }
    
    static let cornerRadius: CGFloat = 8.0
}
