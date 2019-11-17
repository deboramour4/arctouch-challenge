//
//  QuizArcTouchTests.swift
//  QuizArcTouchTests
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import XCTest
@testable import QuizArcTouch

class QuizArcTouchTests: XCTestCase {
    
    var mockNetworkManager: NetworkManager!
    var mockQuizService: QuizService!
    var mockViewModel: QuizViewModel!

    override func setUp() {
        super.setUp()
        mockQuizService = QuizService()
        mockViewModel = QuizViewModel()
    }

    override func tearDown() {
        mockNetworkManager = nil
        mockQuizService = nil
        mockViewModel = nil
        super.tearDown()
    }

    // MARK: - Model Tests
    func testSuccessfulQuizAnswerDecoding() {
        let json = """
        {
          "question": "Any question?",
          "answer": [
            "text1",
            "text2",
            "text3"
          ]
        }
        """.data(using: .utf8)!
        
        do {
            let quizAnswer = try JSONDecoder().decode(QuizAnswer.self, from: json)
            
            XCTAssertEqual(quizAnswer.question, "Any question?")
            XCTAssertEqual(quizAnswer.answer?.count, 3)
            XCTAssertEqual(quizAnswer.answer, ["text1", "text2", "text3"])
        } catch _ {
            XCTFail()
        }
    }
    
    func testNilQuizAnswerDecoding() {
        let json = """
        {
          "question": null,
          "answer": null
        }
        """.data(using: .utf8)!
        
        do {
            let quizAnswer = try JSONDecoder().decode(QuizAnswer.self, from: json)
            
            XCTAssertNil(quizAnswer.question)
            XCTAssertNil(quizAnswer.answer)
        } catch _ {
            XCTFail()
        }
    }
    
    // MARK: - Network Tests
    func testFailRequestingQuizAnswers() {
        mockNetworkManager = NetworkManager("wrong string url")
        mockQuizService = QuizService(mockNetworkManager)
        
        mockQuizService.getQuizAnswersRequest { (response) -> (Void) in
            XCTAssertNil(response)
        }
    }
    
    func testSuccessRequestingQuizAnswers() {
        mockQuizService.getQuizAnswersRequest { (response) -> (Void) in
            XCTAssertNotNil(response)
        }
    }
    
    // MARK: - View Model Tests
    func testStartTimerCounting() {
        mockViewModel.didTapActionButton()
        
        XCTAssertEqual(mockViewModel.buttonTitle, "Reset")
    }
    
    func testResetTimerAndCounter() {
        mockViewModel.didTapAlertAction()
        
        XCTAssertEqual(mockViewModel.timerText, "05:00")
        XCTAssertEqual(mockViewModel.counterText, "00/00")
    }
}
