//
//  KeyboardScrollHelper.swift
//  Core
//
//  Created by Piotr Fraccaro on 11/04/2021.
//

import UIKit

public final class KeyboardScrollHelper {
    
    private let scrollView: UIScrollView
    private let viewToBeShown: UIView
    
    private var isKeyboardVisible: Bool = false
    private var keyboardRect: CGRect = .zero
    
    public init(scrollView: UIScrollView,
                viewToBeShown: UIView) {
        self.scrollView = scrollView
        self.viewToBeShown = viewToBeShown
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func scrollToView(_ viewToBeShown: UIView) {
        guard isKeyboardVisible else {
            resetScrollContentOffset()
            return
        }
        setupScrollContentOffset(with: keyboardRect)
    }
}

// MARK: - Observers

private extension KeyboardScrollHelper {
    
    func addObservers() {
        NotificationCenterHelper.shared.addObserver(observer: self,
                                                    selector: #selector(onKeyboardWillShow(_:)),
                                                    name: .keyboardWillShow)
        NotificationCenterHelper.shared.addObserver(observer: self,
                                                    selector: #selector(onKeyboardWillHide),
                                                    name: .keyboardWillHide)
    }
    
    func removeObservers() {
        NotificationCenterHelper.shared.removeObserver(observer: self, name: .keyboardWillShow)
        NotificationCenterHelper.shared.removeObserver(observer: self, name: .keyboardWillHide)
    }
}

// MARK: - Selectors

private extension KeyboardScrollHelper {
    
    @objc func onKeyboardWillShow(_ notification: Notification) {
        isKeyboardVisible = true
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        setupScrollContentOffset(with: keyboardRectangle)
    }
    
    @objc func onKeyboardWillHide() {
        isKeyboardVisible = false
        resetScrollContentOffset()
    }
}

// MARK: - Private Methods

private extension KeyboardScrollHelper {
    
    func setupScrollContentOffset(with keyboardRectangle: CGRect) {
        guard keyboardRectangle.origin.y < (viewToBeShown.frame.origin.y + viewToBeShown.frame.size.height) else {
            return
        }
        let contentOffsetY = viewToBeShown.frame.origin.y
            - (keyboardRectangle.origin.y + Constants.Padding.keyboardTop)
            + viewToBeShown.frame.size.height
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY), animated: true)
    }
    
    func resetScrollContentOffset() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

// MARK: - Constants

private struct Constants {
    
    struct Padding {
        static let keyboardTop: CGFloat = 16.0
    }
}
