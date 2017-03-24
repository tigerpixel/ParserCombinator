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
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = comma.run(withInput: ",,") {
            XCTAssertEqual(",", results.result)
            XCTAssertEqual(",", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = comma.run(withInput: ",has a comma") {
            XCTAssertEqual(",", results.result)
            XCTAssertEqual("has a comma", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: comma, with: "not a comma") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ot a comma", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: comma, with: "1,") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual(",", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: comma))

    }

    func testCharacterIsFullstop() {

        if case .success(let results) = fullstop.run(withInput: ".") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = fullstop.run(withInput: "..") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual(".", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = fullstop.run(withInput: ".has a full stop") {
            XCTAssertEqual(".", results.result)
            XCTAssertEqual("has a full stop", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "not a full stop") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ot a full stop", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "1.") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual(".", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: fullstop))
    }

}
