//
//  EnrollmentViewController.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Resolver

protocol EnrollmentViewControllerDelegate: AnyObject {
    
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
    
    public class func create() -> EnrollmentViewController {
        let vc = EnrollmentViewController()
        return vc
    }
    
    override public func loadView() {
        self.view = EnrollmentView(delegate: self)
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
        mainView?.shouldEnableEnrollButton(false)
    }
    
    func onEnrollmentError(with message: String) {
        
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
