//
//  BuilderChain.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

protocol BuilderChain {}

extension BuilderChain where Self: AnyObject {
    
    @discardableResult
    func set<T>(_ property: ReferenceWritableKeyPath<Self, T>, to value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
    
    @discardableResult
    func run(_ handler: ((Self) -> Void)) -> Self {
        handler(self)
        return self
    }
}
