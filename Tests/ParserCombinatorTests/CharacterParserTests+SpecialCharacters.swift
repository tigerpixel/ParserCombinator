//
//  CharacterParserTests+SpecialCharacters.swift
//  ParserCombinator
//
//  Created by Liam on 21/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

extension CharacterParserTests {

    // MARK: Tests of pre-made pasers for frequently used characters.

    func testCharacterIsComma() {

        if case .success(let results) = comma.run(withInput: ",") {
            XCTAssertEqual(",", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = comma.run(withInput: ",,") {
            XCTAssertEqual(",", results.result)
            XCTAssertEqual(",", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = comma.run(withInput: ",has a comma") {
            XCTAssertEqual(",", results.result)
            XCTAssertEqual("has a comma", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: comma, with: "not a comma") {
            XCTAssertEqual("n", unexpected.token)
            XCTAssertEqual("ot a comma", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: comma, with: "1,") {
            XCTAssertEqual("1", unexpected.token)
            XCTAssertEqual(",", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: comma))

    }

    func testCharacterIsFullstop() {

        if case .success(let results) = fullstop.run(withInput: ".") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = fullstop.run(withInput: "..") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual(".", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = fullstop.run(withInput: ".has a full stop") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual("has a full stop", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "not a full stop") {
            XCTAssertEqual("n", unexpected.token)
            XCTAssertEqual("ot a full stop", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "1.") {
            XCTAssertEqual("1", unexpected.token)
            XCTAssertEqual(".", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: fullstop))
    }

}
