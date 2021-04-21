//
//  FormTextInput.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import UIKit

public protocol FormTextInputDelegate: AnyObject {
    func didBeginEditing(_ textField: TextField)
    func contentChanged(_ textField: TextField)
    func didEndEditing(_ textField: TextField)
}

public final class FormTextInput: UIView {
    
    public weak var delegate: FormTextInputDelegate?
    
    private let textField: TextField
    private let textFieldBorderColor: UIColor
    private let errorLabel: Label
    private let errorColor: UIColor
    private let successColor: UIColor
    
    public init(textField: TextField,
                borderColor: UIColor = .black,
                errorLabel: Label,
                errorColor: UIColor = .red,
                successColor: UIColor = .green,
                accessibilityIdentifier: String? = "",
                accessibilityLabel: String? = "") {
        self.textField = textField
        self.textFieldBorderColor = borderColor
        self.errorLabel = errorLabel
        self.errorColor = errorColor
        self.successColor = successColor
        super.init(frame: .zero)
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityLabel = accessibilityLabel
        
        setupTextField()
        setupErrorLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showError(with message: String) {
        errorLabel.text = message
        showErrorLabel()
        textField.setBorderColor(errorColor)
    }
    
    public func hideError() {
        errorLabel.text = ""
        hideErrorLabel()
        textField.setBorderColor(textFieldBorderColor)
    }
    
    public func showSuccess() {
        textField.setBorderColor(successColor)
    }
}

// MARK: - Private methods

private extension FormTextInput {
    
    func setupTextField() {
        textField.didBeginEditing = onTextFieldDidBeginEditing
        textField.didChangeContent = onTextFieldContentChanged
        textField.didEndEditing = onTextFieldDidEndEditing
        addSubview(textField)
        textField.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            top: topAnchor,
            padding: Constants.Padding.textField
        )
        textField.heightAnchor
            .constraint(equalToConstant: Constants.Size.textField.height)
            .isActive = true
    }
    
    func setupErrorLabel() {
        addSubview(errorLabel)
        errorLabel.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            top: textField.bottomAnchor,
            bottom: bottomAnchor,
            padding: Constants.Padding.errorLabel
        )
        errorLabel.heightAnchor
            .constraint(equalToConstant: Constants.Size.errorLabel.height)
            .isActive = true
    }
    
    func onTextFieldDidBeginEditing(_ textField: TextField) {
        delegate?.didBeginEditing(textField)
    }
    
    func onTextFieldContentChanged(_ textField: TextField) {
        delegate?.contentChanged(textField)
    }
    
    func onTextFieldDidEndEditing(_ textField: TextField) {
        delegate?.didEndEditing(textField)
    }
}

// MARK: - Animations

private extension FormTextInput {
    
    func showErrorLabel() {
        UIView.animate(withDuration: Constants.TimeIntervals.showErrorLabel) { [weak self] in
            self?.errorLabel.alpha = 1
            self?.errorLabel.isHidden = false
        }
    }
    
    func hideErrorLabel() {
        UIView.animate(withDuration: Constants.TimeIntervals.hideErrorLabel) { [weak self] in
            self?.errorLabel.alpha = 0
            self?.errorLabel.isHidden = true
        }
    }
}

// MARK: - Constants

private struct Constants {
    
    struct Padding {
        static let textField: UIEdgeInsets = .init(top: 8, left: 16, bottom: .zero, right: 16)
        static let errorLabel: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    struct Size {
        static let textField: CGSize = .init(width: .zero, height: 40)
        static let errorLabel: CGSize = .init(width: .zero, height: 13)
    }
    
    struct TimeIntervals {
        static let showErrorLabel: TimeInterval = 0.3
        static let hideErrorLabel: TimeInterval = 0.3
    }
}
