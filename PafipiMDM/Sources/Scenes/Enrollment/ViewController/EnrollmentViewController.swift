//
//  EnrollmentViewController.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Resolver

protocol EnrollmentViewControllerDelegate: AnyObject {
    
    func onEnrollmentFinish()
}

protocol EnrollmentViewControllerInput: AnyObject {
    
    func didRegisterForRemoteNotifications(with deviceToken: Data)
}

public final class EnrollmentViewController: UIViewController {
    
    weak var delegate: EnrollmentViewControllerDelegate?
    
    @LazyInjected private var viewModel: EnrollmentViewModel
        
    private var mainView: EnrollmentView? {
        return view as? EnrollmentView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func create(with deviceToken: Data? = nil) -> EnrollmentViewController {
        let vc = EnrollmentViewController()
        vc.viewModel.setDeviceToken(deviceToken)
        return vc
    }
    
    override public func loadView() {
        self.view = EnrollmentView(delegate: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - EnrollmentViewModelOutput

extension EnrollmentViewController: EnrollmentViewModelOutput {

    func onUrlValidationSuccess() {
        mainView?.updateEnrollmentAddressInput(isValid: true)
        mainView?.shouldEnableEnrollButton(true)
    }
    
    func onUrlValidationError(with message: String) {
        mainView?.updateEnrollmentAddressInput(isValid: false, message: message)
        mainView?.shouldEnableEnrollButton(true)
    }
    
    func onEnrollmentError(with message: String) {
        let alert = UIAlertController(
            title: Localizations.enrollErrorAlertTitle,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: Localizations.ok,
            style: .default) { _ in }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func onUnknownError() {
        let alert = UIAlertController(
            title: Localizations.unknownErrorAlertTitle,
            message: Localizations.unknownErrorAlertMessage,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: Localizations.ok,
            style: .default) { _ in }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func onEnrollmentFinished() {
        delegate?.onEnrollmentFinish()
    }
}

// MARK: - EnrollmentViewDelegate

extension EnrollmentViewController: EnrollmentViewDelegate {
    
    func getEnrollmentAddress() -> String {
        viewModel.getEnrollmentAddress()
    }
    
    func didChangeEnrollmentAddress(_ address: String) {
        viewModel.setEnrollmentAddress(address)
    }
    
    func didEndEditingEnrollmentAddress(_ address: String) {
        viewModel.setEnrollmentAddress(address)
        viewModel.validateEnrollmentAddress()
    }

    func didTapEnrollButton() {
        viewModel.startEnrollment()
    }
}

// MARK: - EnrollmentViewControllerInput

extension EnrollmentViewController: EnrollmentViewControllerInput {
    
    func didRegisterForRemoteNotifications(with deviceToken: Data) {
        viewModel.setDeviceToken(deviceToken)
    }
}
