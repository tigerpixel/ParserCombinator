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

    ///Consumes zero, one or more tokens and resolve them into a result of the correct type.
    let parse: (TokenStream) -> ParseResult<Output>

}
