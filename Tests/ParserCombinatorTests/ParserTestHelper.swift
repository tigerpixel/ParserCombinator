//
//  ParserTestHelper.swift
//  ParserCombinator
//
//  Created by Liam on 21/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

@testable import ParserCombinator

// MARK: Character test helper methods.

struct ParserTestHelper {

    // MARK: A simple test parser. Checks for a value of "a" and moves on one character.

    static func testAParser() -> Parser<Bool> {

        return Parser { stream in

            guard let character = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            let result: Bool = (character == "a")
            // Need to drop first element so tht the parser moves on.
            return .success(result: result, tail: stream.dropFirst())
        }
    }

    static func hasInsufficiantTokens<Output>(parser: Parser<Output>, with tokens: String = "") -> Bool {

        if case .failure(let reason) = parser.run(withInput: tokens) {
            return .insufficiantTokens == reason
        }

        return false
    }

    static func findUnexpectedToken<Output>(running parser: Parser<Output>, with tokens: String)
        -> (token: TokenStream, tail: TokenStream)? {

        if
            case .failure(let reason) = parser.run(withInput: tokens),
            case .unexpectedToken(let token, let tail) = reason
        {
            return (token: token, tail: tail)
        }

        return nil
    }

}
