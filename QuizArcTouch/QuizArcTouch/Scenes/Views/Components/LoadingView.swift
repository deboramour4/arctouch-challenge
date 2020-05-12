//
//  LoadingView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class LoadingView: BaseView {
    
    // MARK: - View elements
    lazy var containerView = UIView(frame: .zero)
        .set(\.backgroundColor, to: UIColor(white: 0, alpha: 0.7))
        .set(\.layer.cornerRadius, to: 16.0)
    
    lazy var activityIndicator = UIActivityIndicatorView(frame: .zero)
        .set(\.style, to: .whiteLarge)
        .set(\.color, to: UIColor.white)
    
    lazy var loadingLabel = UILabel(frame: .zero)
        .set(\.text, to: "Loading...")
        .set(\.textColor, to: UIColor.white)
        .set(\.textAlignment, to: .center)
        .set(\.font, to: UIFont.button)
    
    // MARK: - Base view overrides
    override func initialize() {
        backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(loadingLabel)
    }
    
    override func autoLayout() {
        containerView
            .anchor(centerX: centerXAnchor)
            .anchor(centerY: centerYAnchor)
            .anchor(widthConstant: 200)
            .anchor(height: containerView.widthAnchor, multiplier: 0.8)
        
        activityIndicator
            .anchor(centerX: containerView.centerXAnchor)
            .anchor(centerY: containerView.centerYAnchor, padding: -24)
            .anchor(width: containerView.widthAnchor, multiplier: 0.5)
            .anchor(height: activityIndicator.widthAnchor)
        
        loadingLabel
            .anchor(centerX: containerView.centerXAnchor)
            .anchor(centerY: containerView.centerYAnchor, padding: 32)
            .anchor(leading: containerView.leadingAnchor, padding: 16)
            .anchor(trailing: containerView.trailingAnchor, padding: 16)
    }
}
