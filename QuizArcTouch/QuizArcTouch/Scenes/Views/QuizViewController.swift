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
        
        bind()
        
        quizViewModel.requestQuizAnswers()
    }
    
    func bind() {
        // Inputs
        
        // Outputs
        quizViewModel.isLoading = { [weak self] (isLoading) in
            if isLoading {
                self?.quizView.startLoading()
            } else {
                self?.quizView.endLoading()
            }
        }
        
        quizViewModel.updatedQuizAnswer = { [weak self] in
            self?.quizView.inputTextField.placeholder = self?.quizViewModel.textFieldPlaceholder
            self?.quizView.titleLabel.text = self?.quizViewModel.titleText
        }
        
        quizView.progressView.counterLabel.text = quizViewModel.counterText
        quizView.progressView.timerLabel.text = quizViewModel.timerText
        quizView.progressView.actionButton.title = quizViewModel.buttonTitle
        
    }
}

