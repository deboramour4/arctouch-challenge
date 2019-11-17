//
//  QuizAnswer.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

struct QuizAnswer: Codable {
    let question: String
    let answer: [String]
}
