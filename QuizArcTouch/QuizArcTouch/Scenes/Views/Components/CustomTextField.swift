//
//  CustomTextField.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    // MARK: - Properties
    private var textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) {
        didSet { setNeedsDisplay() }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        backgroundColor = UIColor.lightGray
        font = UIFont.body
        borderStyle = .none
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
    }

    // MARK: - Overrides
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: bounds.inset(by: textInsets))
    }
}
