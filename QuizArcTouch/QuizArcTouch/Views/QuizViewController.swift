//
//  ViewController.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    let quizView = QuizView()
    let quizViewModel = QuizViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = quizView
    }
}

