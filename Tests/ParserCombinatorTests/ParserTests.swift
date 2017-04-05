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

    // MARK: Test methods which convert one type of parser to another.

    func testMapParser() {

        // Boolean result of mapped to the strings 'true' and 'false'.
        let parserUnderTest = ParserTestHelper.aParser().map { $0 ? "true" : "false" }

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

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
