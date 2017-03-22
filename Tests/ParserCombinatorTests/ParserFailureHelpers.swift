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

    static func expectInsufficiantCharacters<Output>(parser: Parser<Output>, withTokens tokens: String = "") -> Bool {

        if case .failure(let reason) = parser.run(withInput: tokens) {
            return .insufficiantTokens == reason
        }

        return false
    }

    static func expectUnexpectedToken<Output>(parser: Parser<Output>, with unexpectedToken: String)
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
