//
//  NumberParserTests.swift
//  ParserCombinator
//
//  Created by Liam on 23/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class NumberParserTests: XCTestCase {

    func testIntegerNumber() {

        let parserUnderTest = integerNumber

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual(1, results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "10") {
            XCTAssertEqual(10, results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1023") {
            XCTAssertEqual(1023, results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "123d") {
            XCTAssertEqual(123, results.result)
            XCTAssertEqual("d", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "aBCD") {
            XCTAssertEqual("a", String(unexpected.token))
            XCTAssertEqual("BCD", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
