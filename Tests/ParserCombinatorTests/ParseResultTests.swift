//
//  ParseResultTests.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParseResultTests: XCTestCase {

    func testParserResultEquality() {

        XCTAssertEqual(ParseFailure.insufficiantTokens, .insufficiantTokens)
        XCTAssertEqual(ParseFailure.custom(message: "one"), .custom(message: "one"))
        XCTAssertEqual(ParseFailure.unexpectedToken(token:"a", tail: "b"),
                       .unexpectedToken(token:"a", tail: "b"))

        // Different types.
        XCTAssertNotEqual(ParseFailure.insufficiantTokens, .custom(message: ""))
        XCTAssertNotEqual(ParseFailure.insufficiantTokens, .unexpectedToken(token:"a", tail: "c"))
        XCTAssertNotEqual(ParseFailure.unexpectedToken(token:"a", tail: "c"), .custom(message: ""))

        // Same unexpected token with different contents.
        XCTAssertNotEqual(ParseFailure.unexpectedToken(token:"a", tail: "b"),
                          .unexpectedToken(token:"c", tail: "c"))

        XCTAssertNotEqual(ParseFailure.unexpectedToken(token:"a", tail: "b"),
                          .unexpectedToken(token:"a", tail: "c"))

        // Same custom type with different message.
        XCTAssertNotEqual(ParseFailure.custom(message: "one"), .custom(message: "two"))
    }

}
