//
//  QuizView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class QuizView: BaseView {

    lazy var loadingView = LoadingView(frame: .zero)
    
    lazy var titleLabel = UILabel(frame: .zero)
        .set(\.font, to: UIFont.largeTitle)
        .set(\.numberOfLines, to: 0)
        .set(\.textColor, to: .black)
    
    lazy var inputTextField = CustomTextField(frame: .zero)
        .set(\.delegate, to: self)
    
    lazy var keywordsTableView = UITableView(frame: .zero, style: .plain)
        .set(\.showsHorizontalScrollIndicator, to: false)
        .set(\.tableFooterView, to: UIView())
    
    lazy var progressView = ProgressView(frame: .zero)
    
    private var progressViewBottomConstraint: NSLayoutConstraint?
    private var progressViewBottomKeyboardConstraint: NSLayoutConstraint?
    
    override func initialize() {
        backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(inputTextField)
        addSubview(keywordsTableView)
        addSubview(progressView)
        addSubview(loadingView)
    }
    
    override func autoLayout() {
        titleLabel
            .anchor(top: topAnchor, padding: 44)
            .anchor(leading: leadingAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 16)
        
        inputTextField
            .anchor(top: titleLabel.bottomAnchor, padding: 16)
            .anchor(leading: leadingAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 16)
            .anchor(heightConstant: 44)
        
        keywordsTableView
            .anchor(top: inputTextField.bottomAnchor, padding: 16)
            .anchor(leading: leadingAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 16)
        
        progressView
            .anchor(top: keywordsTableView.bottomAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(height: heightAnchor, multiplier: 0.2)
        
        progressViewBottomConstraint = progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        progressViewBottomConstraint?.isActive = true
        progressViewBottomKeyboardConstraint = nil
        
        loadingView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let targetFrame = keyboardFrame.cgRectValue
        
        if let bottomConstraint = progressViewBottomKeyboardConstraint {
            progressViewBottomConstraint?.isActive = false
            bottomConstraint.isActive = true
        } else {
            progressViewBottomKeyboardConstraint = progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -targetFrame.height)
            progressViewBottomConstraint?.isActive = false
            progressViewBottomKeyboardConstraint?.isActive = true
        }
        layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        progressViewBottomKeyboardConstraint?.isActive = false
        progressViewBottomConstraint?.isActive = true
        layoutIfNeeded()
    }
    
    public func startLoading() {
        loadingView.isHidden = false
        loadingView.activityIndicator.startAnimating()
    }
    
    public func endLoading() {
        loadingView.activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
}
