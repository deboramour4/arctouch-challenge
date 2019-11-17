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
    let numberFormatter = NumberFormatter()
        .set(\.minimumIntegerDigits, to: 2)
    
    // Typealias
    typealias QuizAnswerClosure = ((QuizAnswer?) ->(Void))
    typealias BooleanClosure = ((Bool) -> (Void))?
    typealias NotifyClosure = (() -> (Void))?
    
    // Model
    private var quizAnswer: QuizAnswer?
    private var service: Network
    
    // Inputs
    private var numberOfHits: Int = 0
    
    // Outputs
    public var isLoading: BooleanClosure = nil
    public var updatedQuizAnswer: NotifyClosure = nil
    
    public var textFieldPlaceholder: String? = "Insert Word"
    
    public var titleText: String? {
        return quizAnswer?.question
    }
    public var timerText: String? {
        return "04:23"
    }
    public var buttonTitle: String? {
        return "Start"
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
    
    private func getQuizAnswers(service: Network, _ completion: @escaping QuizAnswerClosure) {
        service.get(endpoint: "/quiz/1") { (result: Result<QuizAnswer, Network.NetworkError>) in
            switch result {
            case .success(let response):
                print("Success question: \(response.question)")
                print("Success answers: \(response.answer)")
                completion(response)
            case .failure(let error):
                switch error {
                default:
                    print("Error : \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
    }
    
    func requestQuizAnswers() {
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
