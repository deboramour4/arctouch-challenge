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
        .set(\.text, to: "What are all the java keywords?")
    
    lazy var inputTextField = CustomTextField(frame: .zero)
        .set(\.placeholder, to: "Insert Word")
    
    lazy var keywordsTableView = UITableView(frame: .zero, style: .plain)
        .set(\.showsHorizontalScrollIndicator, to: false)
    
    lazy var progressView = ProgressView(frame: .zero)
    
    override func initialize() {
        backgroundColor = .white
    }
    
    override func addViews() {
        addSubview(loadingView)
        addSubview(titleLabel)
        addSubview(inputTextField)
        addSubview(keywordsTableView)
        addSubview(progressView)
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
            .anchor(bottom: bottomAnchor)
            .anchor(height: heightAnchor, multiplier: 0.2)
        
        loadingView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    }

}
