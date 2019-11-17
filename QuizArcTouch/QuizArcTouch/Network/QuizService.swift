//
//  QuizService.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 17/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class QuizService {
    
    private let manager: NetworkManager
    
    // MARK: - Initializer
    init(_ manager: NetworkManager = NetworkManager("https://codechallenge.arctouch.com")) {
        self.manager = manager
    }
    
    public func getQuizAnswersRequest(_ completion: @escaping ((QuizAnswer?) -> (Void))) {
        manager.headers = [.contentType]
        
        manager.get(endpoint: "/quiz/1") { (result: Result<QuizAnswer, NetworkManager.RequestError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
