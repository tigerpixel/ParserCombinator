//
//  ParserFailureHelpers.swift
//  ParserCombinator
//
//  Created by Liam on 21/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

@testable import ParserCombinator

// MARK: Character test helper methods.

struct ParserFailureHelpers {

    static func expectInsufficiantCharacters(parser: Parser<Character>) -> Bool {

        if case .failure(let reason) = parser.run(withInput: "") {
            return .insufficiantTokens == reason
        }

        return false
    }

    static func expectUnexpectedToken(parser: Parser<Character>, with unexpectedToken: String)
        -> (token: TokenStream, tail: TokenStream)? {

        if
            case .failure(let reason) = parser.run(withInput: unexpectedToken),
            case .unexpectedToken(let token, let tail) = reason
        {
            return (token: token, tail: tail)
        }

        return nil
    }

}
