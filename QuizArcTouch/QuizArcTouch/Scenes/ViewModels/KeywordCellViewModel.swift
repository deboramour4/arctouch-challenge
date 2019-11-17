//
//  AnswersTableCellViewModel.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 17/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

struct KeywordCellViewModel {
    
    // MARK: - Properties
    private let keyword: String
    
    // MARK: - Output strings
    public var keywordText: String {
        return keyword.firstCapitalized
    }
    
    // MARK: - Initializer
    init(keyword: String) {
        self.keyword = keyword
    }
}
