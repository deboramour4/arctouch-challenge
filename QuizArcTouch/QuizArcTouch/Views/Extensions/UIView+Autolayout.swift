//
//  UIView+Autolayout.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: top, constant: padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(bottom: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: bottom, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(leading: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: leading, constant: padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(trailing: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: trailing, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(centerX: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX, constant: padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(centerY: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: centerY, constant: padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(widthConstant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(heightConstant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(width: NSLayoutDimension, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: width, multiplier: multiplier, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(height: NSLayoutDimension, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: height, multiplier: multiplier, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(aspectRatio: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: aspectRatio).isActive = true
        return self
    }
}
