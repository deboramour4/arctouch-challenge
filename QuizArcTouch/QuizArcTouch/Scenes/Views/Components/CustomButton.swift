//
//  CustomButton.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        setTitleColor(UIColor.white, for: .normal)
        setBackgroundImage(UIColor.primaryColor.image(), for: .normal)
        setBackgroundImage(UIColor.primaryColorDarker.image(), for: .highlighted)
        titleLabel?.font = UIFont.button
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 0
        contentHorizontalAlignment = .center
    }

}
