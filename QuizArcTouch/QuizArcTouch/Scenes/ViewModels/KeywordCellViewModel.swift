//
//  AnswersTableCellViewModel.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 17/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

struct KeywordCellViewModel {
       
    private let keyword: String
    
    public var keywordText: String {
        return keyword.firstCapitalized
    }
    
    init(keyword: String) {
        self.keyword = keyword
    }
}
