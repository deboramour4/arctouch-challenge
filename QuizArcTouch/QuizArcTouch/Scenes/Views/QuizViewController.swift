//
//  ViewController.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // MARK: - Properties
    let quizView = QuizView()
    let quizViewModel = QuizViewModel()

    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = quizView
        
        bind()
        
        quizViewModel.didFinishBinding()
        
        quizView.keywordsTableView.dataSource = self
    }
    
    // MARK: - Binding with ViewModel
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
            self?.quizView.keywordsTableView.reloadData()
        }
        
        quizViewModel.didFinishQuizWinning = { [weak self] (didWin) in
            if didWin {
                self?.quizView.inputTextField.resignFirstResponder()
                
                self?.showAlert(self?.quizViewModel.wonAlertTitle, message: self?.quizViewModel.wonAlertMessage, button: self?.quizViewModel.wonAlertAction, handler: { (alert) in
                    self?.quizViewModel.didTapAlertAction()
                })
            } else {
                self?.quizView.inputTextField.resignFirstResponder()
                
                self?.showAlert(self?.quizViewModel.lostAlertTitle, message: self?.quizViewModel.lostAlertMessage, button: self?.quizViewModel.lostAlertAction, handler: { (alert) in
                    self?.quizViewModel.didTapAlertAction()
                })
            }
        }
        
        quizViewModel.gotErrorOnRequest = { [weak self] in
            self?.showAlert(self?.quizViewModel.errorAlertTitle, message: self?.quizViewModel.errorAlertMessage, button: self?.quizViewModel.lostAlertAction, handler: { (alert) in
                self?.quizViewModel.didTapErrorAlertAction()
            })
        }
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        quizViewModel.textFieldDidChange(textField.text)
    }
}

