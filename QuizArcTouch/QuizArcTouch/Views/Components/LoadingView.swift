//
//  LoadingView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class LoadingView: BaseView {
    
    lazy var backgroundView = UIView(frame: .zero)
        .set(\.backgroundColor, to: UIColor(white: 0, alpha: 0.5))
    
    lazy var containerView = UIView(frame: .zero)
        .set(\.backgroundColor, to: UIColor(white: 0, alpha: 0.7))
        .set(\.layer.cornerRadius, to: 16.0)
    
    lazy var activityIndicator = UIActivityIndicatorView(frame: .zero)
        .set(\.style, to: .large)
        .set(\.color, to: UIColor.white)
    
    lazy var loadingLabel = UILabel(frame: .zero)
        .set(\.text, to: "Loading...")
        .set(\.textColor, to: UIColor.white)
        .set(\.textAlignment, to: .center)
        .set(\.font, to: UIFont.button)
    
    override func initialize() {
        backgroundView.isHidden = true
    }
    
    override func addViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(loadingLabel)
    }
    
    override func autoLayout() {
        backgroundView
            .anchor(centerX: centerXAnchor)
            .anchor(centerY: centerYAnchor)
            .anchor(width: widthAnchor)
            .anchor(height: heightAnchor)
        
        containerView
            .anchor(centerX: backgroundView.centerXAnchor)
            .anchor(centerY: backgroundView.centerYAnchor)
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
    
    public func show() {
        backgroundView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        backgroundView.isHidden = true
    }
}
