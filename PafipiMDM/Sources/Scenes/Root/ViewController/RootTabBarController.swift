//
//  RootTabBarController.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 28/03/2021.
//

import UIKit
import Resolver
import Core

protocol RootTabBarControllerDelegate: AnyObject {
    
}

final class RootTabBarController: UITabBarController {

    weak var controllerDelegate: RootTabBarControllerDelegate?
    
    private let tabBarViews: [UIViewController]
    
    @LazyInjected private var viewModel: RootTabBarViewModel
    
    init(tabBarViews: [UIViewController]) {
        self.tabBarViews = tabBarViews
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Common.background
        viewControllers = tabBarViews
        tabBar.tintColor = Colors.Common.tint
    }
}

// MARK: - RootTabBarViewModelOutput

extension RootTabBarController: RootTabBarViewModelOutput {
    
}
