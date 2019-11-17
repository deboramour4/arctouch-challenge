//
//  QuizView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class QuizView: BaseView {

    // MARK: - View elements
    public lazy var loadingView = LoadingView(frame: .zero)
    
    public lazy var titleLabel = UILabel(frame: .zero)
        .set(\.font, to: UIFont.largeTitle)
        .set(\.numberOfLines, to: 0)
        .set(\.textColor, to: .black)
    
    public lazy var inputTextField = CustomTextField(frame: .zero)
        .set(\.delegate, to: self)
        .set(\.autocapitalizationType, to: .none)
    
    public lazy var keywordsTableView = UITableView(frame: .zero, style: .plain)
        .set(\.showsHorizontalScrollIndicator, to: false)
        .set(\.showsHorizontalScrollIndicator, to: false)
        .set(\.tableFooterView, to: UIView())
        .set(\.allowsSelection, to: false)
        .run { (tableView) in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    public lazy var progressView = ProgressView(frame: .zero)
    
    // MARK: - Properties
    private var pViewBottomConstraint: NSLayoutConstraint?
    private var pViewKeyboardPortraitConstraint: NSLayoutConstraint?
    private var pViewKeyboardLandscapeConstraint: NSLayoutConstraint?
    private var currentKeyboardHeight: CGFloat = CGFloat(0)
    private var portraitKeyboardHeight: CGFloat?
    private var landscapeKeyboardHeight: CGFloat?
    private var isInPortraitMode: Bool = true
    
    // MARK: - Base view overrides
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
            .anchor(bottom: safeAreaLayoutGuide.bottomAnchor, padding: 135)
        
        progressView
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(heightConstant: 135)

        pViewBottomConstraint = progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        pViewBottomConstraint?.isActive = true
        pViewKeyboardPortraitConstraint = nil
        pViewKeyboardLandscapeConstraint = nil
        
        loadingView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    }
    
    // MARK: - Class methods
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let targetFrame = keyboardFrame.cgRectValue
        
        updateOrientationMode(keyboardFrame: targetFrame.height)
        
        if let portraitConstraint = pViewKeyboardPortraitConstraint {
                        
            if isInPortraitMode {

                // Updating active constraints
                pViewBottomConstraint?.isActive = false
                pViewKeyboardLandscapeConstraint?.isActive = false
                portraitConstraint.isActive = true

            } else {

                if let landscapeConstraint = pViewKeyboardLandscapeConstraint, !isInPortraitMode {
                    
                    // Updating active constraints
                    pViewBottomConstraint?.isActive = false
                    pViewKeyboardPortraitConstraint?.isActive = false
                    landscapeConstraint.isActive = true

                } else {

                    // First time calculating keyboard height in landscape
                     guard let landscape = landscapeKeyboardHeight else { return }
                    currentKeyboardHeight = landscape
                    
                    pViewKeyboardLandscapeConstraint = progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -landscape)
                    pViewBottomConstraint?.isActive = false
                    pViewKeyboardPortraitConstraint?.isActive = false
                    pViewKeyboardLandscapeConstraint?.isActive = true
                }
            }

        } else {
            // First time calculating keyboard height in portrait
            guard let portrait = portraitKeyboardHeight else { return }
            currentKeyboardHeight = portrait
            
            pViewKeyboardPortraitConstraint = progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -portrait)
            pViewBottomConstraint?.isActive = false
            pViewKeyboardLandscapeConstraint?.isActive = false
            pViewKeyboardPortraitConstraint?.isActive = true
        }
        
        layoutIfNeeded()
    }
    
    private func updateOrientationMode(keyboardFrame: CGFloat) {
        guard let portrait = portraitKeyboardHeight else {
            // First time in portrait mode
            portraitKeyboardHeight = keyboardFrame
            isInPortraitMode = true
            return
        }
        
        if keyboardFrame != currentKeyboardHeight {
            guard let _ = landscapeKeyboardHeight else {
                // First time landscape mode
                landscapeKeyboardHeight = keyboardFrame
                isInPortraitMode = false
                return
            }
        }
        
        // Update orientation mode
        isInPortraitMode = keyboardFrame == portrait ? true : false
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        pViewKeyboardPortraitConstraint?.isActive = false
        pViewKeyboardLandscapeConstraint?.isActive = false
        pViewBottomConstraint?.isActive = true
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
