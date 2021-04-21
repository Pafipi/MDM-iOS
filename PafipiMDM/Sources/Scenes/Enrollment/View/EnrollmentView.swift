//
//  EnrollmentView.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Core

protocol EnrollmentViewDelegate: AnyObject {
    
    func getEnrollmentAddress() -> String
    func didChangeEnrollmentAddress(_ address: String)
    func didEndEditingEnrollmentAddress(_ address: String)
    func didTapEnrollButton()
}

final class EnrollmentView: UIView {
    
    weak var delegate: EnrollmentViewDelegate?
    
    private var scrollView: UIScrollView?
    private var scrollContentView: UIView?
    private var appLogoImageView: UIImageView?
    private var serverAddressInput: FormTextInput?
    private var enrollButton: Button?
    private var keyboardScrollHelper: KeyboardScrollHelper?
    
    init(delegate: EnrollmentViewDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shouldEnableEnrollButton(_ enabled: Bool) {
        enrollButton?.setUserInteractionEnabled(enabled)
    }
    
    func updateEnrollmentAddressInput(isValid: Bool, message: String? = nil) {
        if isValid {
            serverAddressInput?.hideError()
        } else {
            serverAddressInput?.showError(with: message ?? "")
        }
    }
}

// MARK: - Private methods

private extension EnrollmentView {
    
    func setup() {
        backgroundColor = Asset.Colors.Common.background.color
        setupScrollView()
        setupAppLogoImageView()
        setupServerAddressInput()
        setupEnrollButton()
        setupKeyboardScrollHelper()
    }
    
    func setupScrollView() {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            top: topAnchor,
            bottom: bottomAnchor
        )
        self.scrollView = scrollView
        
        let scrollContentView = UIView()
        scrollView.addSubview(scrollContentView)
        scrollContentView.anchor(
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor
        )
        scrollContentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor)
            .isActive = true
        self.scrollContentView = scrollContentView
    }
    
    func setupAppLogoImageView() {
        guard let scrollContentView = scrollContentView else { return }
        let appLogo = Asset.Assets.pafipiLogo.image
        let imageView = UIImageView(image: appLogo)
        scrollContentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = Accessibility.Identifiers.appLogoImageView
        imageView.accessibilityLabel = Accessibility.Labels.appLogoImageView
        imageView.anchor(
            leading: scrollContentView.leadingAnchor,
            trailing: scrollContentView.trailingAnchor,
            top: scrollContentView.topAnchor,
            padding: Constants.Padding.appLogoImageView
        )
        imageView.heightAnchor
            .constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
            .isActive = true
        self.appLogoImageView = imageView
    }
    
    func setupServerAddressInput() {
        guard let scrollContentView = scrollContentView,
              let imageView = appLogoImageView else { return }
        let serverAddressInput = createServerAddressInput()
        scrollContentView.addSubview(serverAddressInput)
        serverAddressInput.anchor(
            leading: scrollContentView.leadingAnchor,
            trailing: scrollContentView.trailingAnchor,
            top: imageView.bottomAnchor,
            padding: Constants.Padding.serverAddressInput
        )
        serverAddressInput.delegate = self
        self.serverAddressInput = serverAddressInput
    }
    
    func setupEnrollButton() {
        guard let scrollContentView = scrollContentView,
              let serverAddressInput = serverAddressInput else { return }
        let enrollButton = Button(
            title: L10n.enrollButtonTitle,
            font: .boldMainStyleFont(ofSize: .mediumLarge),
            tintColor: Asset.Colors.Common.justWhite.color,
            textColor: Asset.Colors.Common.justWhite.color,
            backgroundColor: Asset.Colors.Common.tint.color,
            disabledColor: Asset.Colors.Common.disabledButtonColor.color,
            cornerRadius: Constants.CornerRadius.enrollButton,
            textAlignment: .center,
            accessibilityIdentifier: Accessibility.Identifiers.enrollButton,
            accessibilityLabel: L10n.enrollButtonTitle
        )
        scrollContentView.addSubview(enrollButton)
        enrollButton.anchor(
            leading: scrollContentView.leadingAnchor,
            trailing: scrollContentView.trailingAnchor,
            top: serverAddressInput.bottomAnchor,
            bottom: scrollContentView.bottomAnchor,
            padding: Constants.Padding.enrollButton,
            size: Constants.Size.enrollButton
        )
        enrollButton.setUserInteractionEnabled(false)
        self.enrollButton = enrollButton
    }
    
    func setupKeyboardScrollHelper() {
        guard let scrollView = scrollView,
              let serverAddressInput = serverAddressInput else { return }
        keyboardScrollHelper = KeyboardScrollHelper(scrollView: scrollView, viewToBeShown: serverAddressInput)
    }
    
    func createServerAddressInput() -> FormTextInput {
        let textField = TextField(
            placeholder: L10n.addressInputPlaceholder,
            font: .regularMainStyleFont(ofSize: .medium),
            cornerRadius: Constants.CornerRadius.serverAddressTextField,
            alignment: .left,
            returnButtonType: .done,
            autocapitalizationType: .none,
            textColor: Asset.Colors.Common.black.color,
            placeholderColor: Asset.Colors.Form.placeholder.color,
            backgroundColor: Asset.Colors.Form.inputBackground.color,
            borderWidth: Constants.Border.serverAddressTextFieldWidth,
            borderColor: Asset.Colors.Common.tint.color,
            debounceContentChange: true,
            accessibilityIdentifier: Accessibility.Identifiers.enrollmentAddressTextField,
            accessibilityLabel: Accessibility.Labels.enrollmentAddressTextField
        )
        let errorLabel = Label(
            text: "",
            font: .boldMainStyleFont(ofSize: .smallest),
            alignment: .left,
            color: Asset.Colors.Common.error.color,
            accessibilityLabel: Accessibility.Identifiers.enrollmentAddressErrorLabel,
            accessibilityIdentifier: Accessibility.Labels.enrollmentAddressErrorLabel
        )
        let formInput = FormTextInput(
            textField: textField,
            borderColor: Asset.Colors.Common.tint.color,
            errorLabel: errorLabel,
            errorColor: Asset.Colors.Common.error.color,
            accessibilityIdentifier: Accessibility.Identifiers.enrollmentAddressInput,
            accessibilityLabel: Accessibility.Labels.enrollmentAddressInput
        )
        return formInput
    }
}

// MARK: - FormTextInputDelegate

extension EnrollmentView: FormTextInputDelegate {
    
    func didBeginEditing(_ textField: TextField) {
        textField.text = delegate?.getEnrollmentAddress()
    }
    
    func contentChanged(_ textField: TextField) {
        delegate?.didChangeEnrollmentAddress(textField.text ?? "")
    }
    
    func didEndEditing(_ textField: TextField) {
        delegate?.didEndEditingEnrollmentAddress(textField.text ?? "")
    }
}

// MARK: - Constants

private struct Constants {
    
    struct Padding {
        static let appLogoImageView: UIEdgeInsets = .init(top: 96, left: 40, bottom: .zero, right: 40)
        static let serverAddressInput: UIEdgeInsets = .init(top: 16, left: 8, bottom: .zero, right: 8)
        static let enrollButton: UIEdgeInsets = .init(top: 16, left: 24, bottom: 16, right: 24)
    }
    
    struct Size {
        static let enrollButton: CGSize = .init(width: .zero, height: 50)
    }
    
    struct CornerRadius {
        static let enrollButton: CGFloat = 12.0
        static let serverAddressTextField: CGFloat = 10.0
    }
    
    struct Border {
        static let serverAddressTextFieldWidth: CGFloat = 1.0
    }
}
