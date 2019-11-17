//
//  QuizViewModel.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class QuizViewModel {

    // Properties
    private var timer: Timer? = nil
    private let totalTimerSeconds: Int = 5 * 60
    private var secondsLeftTimer: Int = 5 * 60
    private var numberOfHits: Int = 0
    private var numberOfAnswers: Int = 0
    
    private var allHitsStrings: [String] = [] {
        didSet {
            let hitsReverseOrder = allHitsStrings.reversed()
            cellViewModels = hitsReverseOrder.map { (keyword) in
                KeywordCellViewModel(keyword: keyword)
            }
        }
    }
    private var cellViewModels: [KeywordCellViewModel] = []
    
    // Typealias
    typealias QuizAnswerClosure = ((QuizAnswer?) ->(Void))
    typealias BooleanClosure = ((Bool) -> (Void))?
    typealias NotifyClosure = (() -> (Void))?
    
    // Model
    private var quizAnswer: QuizAnswer?
    private var service: Network
    
    // Binding closures
    public var isLoading: BooleanClosure = nil
    public var updatedQuizAnswer: NotifyClosure = nil
    public var updatedTimerValue: NotifyClosure = nil
    public var updatedCounterValue: NotifyClosure = nil
    public var didFinishQuizWinning: BooleanClosure = nil
    public var gotErrorOnRequest: NotifyClosure = nil
    
    // Output strings
    public var textFieldPlaceholder: String? = "Insert Word"
    public var wonAlertTitle: String? = "Congratulations"
    public var wonAlertMessage: String? = "Good job! You found all the answers on time. Keep up with the great work."
    public var wonAlertAction: String? = "Play again"
    public var lostAlertTitle: String? = "Time finished"
    public var lostAlertAction: String? = "Try again"
    public var errorAlertTitle: String? = "Sorry"
    public var errorAlertMessage: String? = "An error occurred during web request."
    
    public var lostAlertMessage: String? {
        return "Sorry, time is up! You got \(numberOfHits) out of \(numberOfAnswers) answers."
    }
    
    public var titleText: String? {
        return quizAnswer?.question
    }
    
    public var timerText: String? {
        let minutes = Int(secondsLeftTimer) / 60 % 60
        let seconds = Int(secondsLeftTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    public var buttonTitle: String? {
        return timer == nil ? "Start" : "Reset"
    }
    
    public var counterText: String? {
        return String(format:"%02i/%02i", numberOfHits, numberOfAnswers)
    }
    
    public var numberOfRows: Int {
        return cellViewModels.count
    }
    
    // Initializer
    init(_ service: Network = Network(api: URL(string: "https://codechallenge.arctouch.com"))) {
        self.service = service
    }
    
    // Private Methods
    private func getQuizAnswersRequest(service: Network, _ completion: @escaping QuizAnswerClosure) {
        service.get(endpoint: "/quiz/1") { (result: Result<QuizAnswer, Network.NetworkError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            self?.secondsLeftTimer -= 1
            self?.updatedTimerValue?()
            
            if let left = self?.secondsLeftTimer, left <= 0 {
                self?.didFinishQuiz(won: false)
            }
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resetCounterAndTimer() {
        secondsLeftTimer = 5 * 60
        updatedTimerValue?()
        
        numberOfHits = 0
        allHitsStrings = []
        updatedCounterValue?()
    }
    
    private func checkHit(_ input: String) {
        let inputLower = input.lowercased()
        
        if let answers = quizAnswer?.answer, answers.contains(inputLower), !allHitsStrings.contains(inputLower) {
            numberOfHits += 1
            allHitsStrings.append(inputLower)
            updatedCounterValue?()
            
            if numberOfHits == numberOfAnswers {
                didFinishQuiz(won: true)
            }
        }
    }
    
    private func didFinishQuiz(won: Bool) {
        invalidateTimer()
        didFinishQuizWinning?(won)
    }
    
    private func requestKeywords() {
        getQuizAnswersRequest(service: service) { [weak self] (response) -> (Void) in
            if let quizAnswer = response {
                self?.quizAnswer = quizAnswer
                self?.numberOfAnswers = quizAnswer.answer.count
                
                DispatchQueue.main.sync {
                    self?.updatedCounterValue?()
                    self?.updatedQuizAnswer?()
                    self?.isLoading?(false)
                }
            } else {
                DispatchQueue.main.sync {
                    self?.gotErrorOnRequest?()
                }
            }
        }
    }
    
    public func getCellViewModel(for indexPath: IndexPath) -> KeywordCellViewModel? {
        return self.cellViewModels[indexPath.row]
    }
    
    // Inputs from view
    public func textFieldDidChange(_ text: String?) {
        if let input = text, timer != nil {
            checkHit(input)
        }
    }
    
    @objc public func didTapActionButton() {
        if timer == nil {
            startTimer()
        } else {
            invalidateTimer()
            resetCounterAndTimer()
        }
    }
    
    public func didFinishBinding() {
        updatedTimerValue?()
        updatedCounterValue?()
        isLoading?(true)
        
        requestKeywords()
    }
    
    public func didTapAlertAction() {
        resetCounterAndTimer()
    }
    
    public func didTapErrorAlertAction() {
        requestKeywords()
    }
    
}
