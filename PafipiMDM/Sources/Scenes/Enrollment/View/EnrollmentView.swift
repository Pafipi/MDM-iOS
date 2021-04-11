//
//  EnrollmentView.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Core

protocol EnrollmentViewDelegate: AnyObject {
    
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
}

// MARK: - Private methods

private extension EnrollmentView {
    
    func setup() {
        backgroundColor = Colors.Common.background
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
        let appLogo = UIImage(named: Constants.Image.appLogoName)
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
            title: LocalizedStrings.Enrollment.enrollButtonTitle,
            font: .boldMainStyleFont(ofSize: .mediumLarge),
            tintColor: Colors.Common.justWhite,
            textColor: Colors.Common.justWhite,
            backgroundColor: Colors.Common.tint,
            cornerRadius: Constants.CornerRadius.enrollButton,
            textAlignment: .center,
            accessibilityIdentifier: Accessibility.Identifiers.enrollButton,
            accessibilityLabel: LocalizedStrings.Enrollment.enrollButtonTitle
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
        self.enrollButton = enrollButton
    }
    
    func setupKeyboardScrollHelper() {
        guard let scrollView = scrollView,
              let serverAddressInput = serverAddressInput else { return }
        keyboardScrollHelper = KeyboardScrollHelper(scrollView: scrollView, viewToBeShown: serverAddressInput)
    }
    
    func createServerAddressInput() -> FormTextInput {
        let textField = TextField(
            placeholder: LocalizedStrings.Enrollment.addressInputPlaceholder,
            font: .regularMainStyleFont(ofSize: .medium),
            alignment: .left,
            returnButtonType: .done,
            textColor: Colors.Common.black,
            accessibilityIdentifier: Accessibility.Identifiers.enrollmentAddressTextField,
            accessibilityLabel: Accessibility.Labels.enrollmentAddressTextField
        )
        let errorLabel = Label(
            text: "",
            font: .boldMainStyleFont(ofSize: .smallest),
            alignment: .left,
            color: Colors.Common.error,
            accessibilityLabel: Accessibility.Identifiers.enrollmentAddressErrorLabel,
            accessibilityIdentifier: Accessibility.Labels.enrollmentAddressErrorLabel
        )
        let formInput = FormTextInput(
            textField: textField,
            errorLabel: errorLabel,
            accessibilityIdentifier: Accessibility.Identifiers.enrollmentAddressInput,
            accessibilityLabel: Accessibility.Labels.enrollmentAddressInput
        )
        return formInput
    }
}

// MARK: - FormTextInputDelegate

extension EnrollmentView: FormTextInputDelegate {
    
    func didBeginEditing(_ textField: TextField) {
        scrollView?.scrollRectToVisible(textField.bounds, animated: true)
    }
    
    func contentChanged(_ textField: TextField) {
        
    }
    
    func didEndEditing(_ textField: TextField) {
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
    }
    
    struct Image {
        static let appLogoName = "pafipi_logo"
    }
}
