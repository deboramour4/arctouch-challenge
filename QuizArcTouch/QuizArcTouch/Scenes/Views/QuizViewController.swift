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
        
        quizViewModel.didFinishBinding()
    }
    
    func bind() {
        // Inputs
        quizView.progressView.actionButton.addTarget(quizViewModel, action: #selector(quizViewModel.didTapActionButton), for: .touchUpInside)
        
        quizView.inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        
        quizViewModel.updatedTimerValue = { [weak self] in
            self?.quizView.progressView.timerLabel.text = self?.quizViewModel.timerText
            self?.quizView.progressView.actionButton.title = self?.quizViewModel.buttonTitle
        }
        
        quizViewModel.updatedCounterValue = { [weak self] in
            self?.quizView.inputTextField.text = ""
            self?.quizView.progressView.counterLabel.text = self?.quizViewModel.counterText
        }
        
        quizViewModel.didWin = {
            //show alert
        }
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        quizViewModel.textFieldDidChange(textField.text)
    }
}

