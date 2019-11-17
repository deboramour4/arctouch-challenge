//
//  ProgressView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class ProgressView: BaseView {
    
    // MARK: - View elements
    lazy var separatorView = UIView(frame: .zero)
        .set(\.backgroundColor, to: UIColor.gray)
    
    lazy var counterLabel = UILabel(frame: .zero)
        .set(\.font, to: UIFont.largeTitle)
        .set(\.numberOfLines, to: 1)
        .set(\.textColor, to: .black)
    
    lazy var timerLabel = UILabel(frame: .zero)
        .set(\.font, to: UIFont.largeTitle)
        .set(\.numberOfLines, to: 1)
        .set(\.textColor, to: .black)
    
    lazy var actionButton = CustomButton(frame: .zero)
    
    // MARK: - Base view overrides
    override func initialize() {
        backgroundColor = UIColor.lightGray
    }
    
    override func addViews() {
        addSubview(separatorView)
        addSubview(counterLabel)
        addSubview(timerLabel)
        addSubview(actionButton)
    }

    override func autoLayout() {
        separatorView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(heightConstant: 1)
        
        counterLabel
            .anchor(top: separatorView.bottomAnchor, padding: 16)
            .anchor(leading: leadingAnchor, padding: 16)
        
        timerLabel
            .anchor(top: separatorView.bottomAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 16)
        
        actionButton
            .anchor(top: counterLabel.bottomAnchor, padding: 16)
            .anchor(top: timerLabel.bottomAnchor, padding: 16)
            .anchor(leading: leadingAnchor, padding: 16)
            .anchor(trailing: trailingAnchor, padding: 16)
            .anchor(bottom: bottomAnchor, padding: 16)
    }
}
