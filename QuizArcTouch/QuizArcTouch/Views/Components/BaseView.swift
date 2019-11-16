//
//  BaseView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    required public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    open func initialize() {}
    
    open func addViews() {}
    
    open func autoLayout() {}
    
    override open func didMoveToSuperview() {
        autoLayout()
    }
    
    private func setup() {
        initialize()
        addViews()
    }
}
