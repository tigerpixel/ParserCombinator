//
//  CharacterParserTestHelpers.swift
//  ParserCombinator
//
//  Created by Liam on 21/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

@testable import ParserCombinator

// MARK: Character test helper methods.

struct CPTHelpers {

    static func runAndExpectInsufficiantCharacters(parser: Parser<Character>) -> Bool {

        if case .failure(let reason) = parser.run(withInput: "") {
            return .insufficiantTokens == reason
        }

        return false
    }

    static func runAndExpectUnexpectedToken(parser: Parser<Character>, with input: String)
        -> (token: TokenStream, tail: TokenStream)? {

        if
            case .failure(let reason) = parser.run(withInput: input),
            case .unexpectedToken(let token, let tail) = reason
        {
            return (token: token, tail: tail)
        }

        return nil
    }

}
