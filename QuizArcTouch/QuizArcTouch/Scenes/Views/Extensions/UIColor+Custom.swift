//
//  UIColor+Custom.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

extension UIColor {
    static let lightGray = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    static let gray = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
    static let primaryColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 0/255.0, alpha: 1.0)
    static let primaryColorDarker = UIColor(red: 190/255.0, green: 100/255.0, blue: 0/255.0, alpha: 1.0)
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
