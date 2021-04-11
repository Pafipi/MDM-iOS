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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func create() -> EnrollmentViewController {
        let vc = EnrollmentViewController()
        vc.viewModel.output = vc
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
    
}

// MARK: - EnrollmentViewDelegate

extension EnrollmentViewController: EnrollmentViewDelegate {
    
}
