//
//  ParserTests.swift
//  ParserCombinator
//
//  Created by Liam on 24/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParserTests: XCTestCase {

    // MARK: A simple test parser. Checks for a value of "a" and moves on one character.

    private func createTestParser() -> Parser<Bool> {

        return Parser { stream in

            guard let character = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            let result: Bool = (character == "a")
            // Need to drop first element so tht the parser moves on.
            return .success(result: result, tail: stream.dropFirst())
        }
    }

    // MARK: Test methods which convert one type of parser to another.

    func testMapParser() {

        // Boolean result of mapped to the strings 'true' and 'false'.
        let parserUnderTest = createTestParser().map { $0 ? "true" : "false" }

        if case .success(let results) = parserUnderTest.run(withInput: "aaa") {
            XCTAssertEqual("true", results.result)
            XCTAssertEqual("aa", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "sss") {
            XCTAssertEqual("false", results.result)
            XCTAssertEqual("ss", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

}
