//
//  QuizViewModel.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class QuizViewModel {
    
    typealias QuizAnswerClosure = ((QuizAnswer?) ->(Void))
    
    var quizAnswer: QuizAnswer?
    
    init(_ service: Network = Network(api: URL(string: "https://codechallenge.arctouch.com"))) {
        
        getQuizAnswers(service: service) { [weak self] (quizAnswer) -> (Void) in
            self?.quizAnswer = quizAnswer
        }
    
    }
    
    func getQuizAnswers(service: Network, _ completion: @escaping QuizAnswerClosure) {
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
    
}
