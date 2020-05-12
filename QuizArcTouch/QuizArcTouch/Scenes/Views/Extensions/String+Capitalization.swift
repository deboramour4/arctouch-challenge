//
//  String+Captalization.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 17/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

extension String {
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
