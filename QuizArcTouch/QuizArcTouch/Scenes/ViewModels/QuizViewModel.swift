//
//  QuizViewModel.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class QuizViewModel {
    
    // Formaters
    private let numberFormatter = NumberFormatter()
        .set(\.minimumIntegerDigits, to: 2)
    
    private var timer: Timer? = nil
    private let totalTimerSeconds: Int = 5 * 60
    private var secondsLeftTimer: Int = 5 * 60
    private var numberOfHits: Int = 0
    private var allHitsStrings: [String] = []
    
    // Typealias
    typealias QuizAnswerClosure = ((QuizAnswer?) ->(Void))
    typealias BooleanClosure = ((Bool) -> (Void))?
    typealias NotifyClosure = (() -> (Void))?
    
    // Model
    private var quizAnswer: QuizAnswer?
    private var service: Network
    
    // Outputs
    public var isLoading: BooleanClosure = nil
    public var updatedQuizAnswer: NotifyClosure = nil
    public var updatedTimerValue: NotifyClosure = nil
    public var updatedCounterValue: NotifyClosure = nil
    public var didWin: NotifyClosure = nil
    
    public var textFieldPlaceholder: String? = "Insert Word"
    
    public var titleText: String? {
        return quizAnswer?.question
    }
    public var timerText: String? {
        let minutes = Int(secondsLeftTimer) / 60 % 60
        let seconds = Int(secondsLeftTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    public var buttonTitle: String? {
        if secondsLeftTimer == totalTimerSeconds {
            return "Start"
        } else {
            return "Reset"
        }
    }
    public var counterText: String? {
        let hitsNSNumber = NSNumber(value: numberOfHits)
        let formattedNumber = numberFormatter.string(from: hitsNSNumber)
        if let numberString = formattedNumber {
            return "\(numberString)/50"
        }
        return nil
    }
    
    init(_ service: Network = Network(api: URL(string: "https://codechallenge.arctouch.com"))) {
        self.service = service
    }
    
    // Methods
    private func getQuizAnswers(service: Network, _ completion: @escaping QuizAnswerClosure) {
        service.get(endpoint: "/quiz/1") { (result: Result<QuizAnswer, Network.NetworkError>) in
            switch result {
            case .success(let response):
//                print("Success question: \(response.question)")
                print("Success answers: \(response.answer)")
                completion(response)
            case .failure(let error):
//                switch error {
//                default:
//                    print("Error : \(error.localizedDescription)")
//                }
                completion(nil)
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            self?.secondsLeftTimer -= 1
            self?.updatedTimerValue?()
            
            if let left = self?.secondsLeftTimer, left <= 0 {
                timer.invalidate()
            }
        }
    }
    
    private func checkHit(_ input: String) {
        let inputLower = input.lowercased()
        
        if let answers = quizAnswer?.answer, answers.contains(inputLower), !allHitsStrings.contains(inputLower) {
            numberOfHits += 1
            allHitsStrings.append(inputLower)
            updatedCounterValue?()
            
            if numberOfHits == 50 {
                timer?.invalidate()
                timer = nil
                didWin?()
            }
        }
    }
    
    // Input
    public func textFieldDidChange(_ text: String?) {
        if let input = text, timer != nil {
            checkHit(input)
        }
    }
    
    @objc public func didTapActionButton() {
        if secondsLeftTimer != 0 {
            startTimer()
        }
    }
    
    public func didFinishBinding() {
        updatedTimerValue?()
        updatedCounterValue?()
        isLoading?(true)
        
        getQuizAnswers(service: service) { [weak self] (response) -> (Void) in
            if let quizAnswer = response {
                self?.quizAnswer = quizAnswer
                
                DispatchQueue.main.sync {
                    self?.updatedQuizAnswer?()
                    self?.isLoading?(false)
                }
            } else {
                print("Error.")
            }
        }
    }
    
}
