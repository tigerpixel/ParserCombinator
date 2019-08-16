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

    // MARK: A set of simple test parsers.

    /* Checks for a value of "a" and moves on one character (token).
    "a" resolves Bool true, anything else that is a token resolves Bool false. No tokens fails.*/

    static func characterAtoTrueParser() -> Parser<Bool> {

        return Parser { stream in

            guard let character = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            let result: Bool = (character == "a")
            // Need to drop first element so tht the parser moves on.
            return .success(result: result, tail: stream.dropFirst())
        }
    }

    /* Checks for a value of the given character and moves on one character (token).
     "a" resolves "a", anything else fails.*/

    static func characterOrFailureParser(with character: Character) -> Parser<Character> {

        return Parser { stream in

            guard let streamToken = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            guard character == streamToken else {
                let tail = stream.dropFirst()
                return .failure(details: .unexpectedToken(token: streamToken, tail: tail))
            }
            // Need to drop first element so tht the parser moves on.
            return .success(result: character, tail: stream.dropFirst())
        }
    }

    /* Checks for a value of the given character and moves on one character (token).
     "a" resolves "a", anything else fails.*/

    static func optionalCharacterParser(with character: Character) -> Parser<Character?> {

        return Parser { stream in

            guard let streamToken = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            guard character == streamToken else {
                return .success(result: nil, tail: stream)
            }
            // Need to drop first element so tht the parser moves on.
            return .success(result: character, tail: stream.dropFirst())
        }
    }

    // MARK: A set of functions to simplify the assessment of a particular result.

    static func hasInsufficiantTokens<Output>(parser: Parser<Output>, with tokens: String = "") -> Bool {

        if case .failure(let reason) = parser.run(withInput: tokens) {
            return .insufficiantTokens == reason
        }

        return false
    }

    static func findUnexpectedToken<Output>(running parser: Parser<Output>, with tokens: String)
        -> (token: Character, tail: Substring)? {

        if
            case .failure(let reason) = parser.run(withInput: tokens),
            case .unexpectedToken(let token, let tail) = reason
        {
            return (token: token, tail: tail)
        }

        return nil
    }

}
