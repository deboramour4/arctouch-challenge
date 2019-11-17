//
//  BaseView.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    
    // MARK: - Initializers
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
    
    private func setup() {
        initialize()
        addViews()
    }
    
    // MARK: - Basic methods
    open func initialize() {}
    
    open func addViews() {}
    
    open func autoLayout() {}
    
    override open func didMoveToSuperview() {
        autoLayout()
    }
    
    // MARK: - Default behavior
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

extension BaseView: UITextFieldDelegate {
    
    // MARK: - Dismiss keyboard
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}
