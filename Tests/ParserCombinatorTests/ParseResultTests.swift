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

        XCTAssertNotEqual(ParseFailure.insufficiantTokens, .custom(message: ""))
        XCTAssertNotEqual(ParseFailure.custom(message: "one"), .custom(message: "two"))
    }

}
