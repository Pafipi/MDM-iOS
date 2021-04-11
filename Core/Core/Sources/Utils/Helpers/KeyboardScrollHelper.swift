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
    private var keyboardHeight: CGFloat = 0.0
    
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
        if isKeyboardVisible {
            let contentOffsetY = viewToBeShown.frame.origin.y + viewToBeShown.frame.size.height + keyboardHeight
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY), animated: true)
        } else {
            let contentOffsetY = viewToBeShown.frame.origin.y + viewToBeShown.frame.size.height
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY), animated: true)
        }
    }
}

// MARK: - Observers

private extension KeyboardScrollHelper {
    
    func addObservers() {
        NotificationCenterWrapper.shared.addObserver(observer: self,
                                                     selector: #selector(onKeyboardWillShow(_:)),
                                                     name: .keyboardWillShow)
        NotificationCenterWrapper.shared.addObserver(observer: self,
                                                     selector: #selector(onKeyboardWillHide),
                                                     name: .keyboardWillHide)
    }
    
    func removeObservers() {
        NotificationCenterWrapper.shared.removeObserver(observer: self, name: .keyboardWillShow)
        NotificationCenterWrapper.shared.removeObserver(observer: self, name: .keyboardWillHide)
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
        keyboardHeight = keyboardRectangle.height
        guard keyboardRectangle.origin.y < (viewToBeShown.frame.origin.y + viewToBeShown.frame.size.height) else {
            return
        }
        let contentOffsetY = viewToBeShown.frame.origin.y
            - (keyboardRectangle.origin.y + Constants.Padding.keyboardTop)
            + viewToBeShown.frame.size.height
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY), animated: true)
    }
    
    @objc func onKeyboardWillHide() {
        isKeyboardVisible = false
        keyboardHeight = 0.0
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

// MARK: - Constants  {

private struct Constants {
    
    struct Padding {
        static let keyboardTop: CGFloat = 16.0
    }
}
