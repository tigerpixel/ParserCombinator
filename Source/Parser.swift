//
//  Parser.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 The core generic parser structure that is combined to make the parser combinator.
 */

public struct Parser<Output> {

    ///A function that specifices the consuming of zero or more tokens and resolving them into a result.
    let parse: (TokenStream) -> ParseResult<Output>

}

public extension Parser {

    /**
     Map the parser from one type to another.
     
     - parameter transform: The transform function for the contained type.
     
     - returns: A mapped parser with the updated type.
     */

    func map<MappedOutput>(_ transform: @escaping (Output) -> MappedOutput) -> Parser<MappedOutput> {

        return Parser<MappedOutput> { stream in
            self.parse(stream).map(transform)
        }
    }

}
