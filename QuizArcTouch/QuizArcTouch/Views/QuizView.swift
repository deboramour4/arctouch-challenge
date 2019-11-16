//
//  QuizView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class QuizView: BaseView {

    lazy var progressView = ProgressView(frame: .zero)
    
    override func initialize() {
        
    }
    
    override func addViews() {
        addSubview(progressView)
    }
    
    override func autoLayout() {
        progressView
            .anchor(top: topAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
            .anchor(bottom: bottomAnchor)
    }

}
