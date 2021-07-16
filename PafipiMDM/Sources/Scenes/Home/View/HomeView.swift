//
//  HomeView.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit
import Core

final class HomeView: UIView {
    
    private lazy var splashImageView = createSplashImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension HomeView {
    
    func setupLayout() {
        setupSplashLayout()
    }
    
    func setupSplashLayout() {
        splashImageView.anchor(
            leading: safeAreaLayoutGuide.leadingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            top: safeAreaLayoutGuide.topAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            padding: Constants.Padding.splashImageView
        )
    }
    
    func createSplashImageView() -> UIImageView {
        let splash = Asset.homePageSplash.image
        let imageView = UIImageView(image: splash)
        imageView.alpha = Constants.Alpha.splashImageView
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = Accessibility.Identifiers.appLogoImageView
        imageView.accessibilityLabel = Accessibility.Labels.appLogoImageView
        return imageView
    }
}

// MARK: - Constants

private struct Constants {
    
    struct Padding {
        static let splashImageView: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    struct Alpha {
        static let splashImageView: CGFloat = 0.2
    }
}
