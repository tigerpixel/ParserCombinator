//
//  Parser+Characters.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

// Parser operates on Character Views (see typealias). Make a convienience method that takes and produces strings.

public extension Parser {
    
    func run(withInput input: String) -> ParseResult<Output> {
        return parse(input.characters)
    }
    
    func runAndResolve(withInput input: String) -> Output? {
        
        guard case .success(let result, _) = parse(input.characters) else {
            return nil
        }
        
        return result
    }
}
