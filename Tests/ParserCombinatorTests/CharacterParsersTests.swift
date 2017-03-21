//
//  CharacterParsersTests.swift
//  ParserCombinator
//
//  Created by Liam on 18/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class CharacterParserTests: XCTestCase {

    // MARK: Tests for the convienience method to make a parser for type "Character".

    func testCharacterWithCondition() {

        let parserUnderTest = character { $0 == "A" }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "AA") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("A", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "Atail") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ottoken", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpectedToken.token))
            XCTAssertEqual("A", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    // MARK: Tests of pre-made pasers using the character parser function for defining sets of common characters.

    func testCharacterInCharacterSet() {

        let parserUnderTest = character(isInCharacterSet: .decimalDigits)

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "1") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "12") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("2", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "1tail") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ottoken", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: ",1") {
            XCTAssertEqual(",", String(unexpectedToken.token))
            XCTAssertEqual("1", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterEqualTo() {

        let parserUnderTest = character(isEqualTo: "A")

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "AA") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("A", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "Atail") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ottoken", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpectedToken.token))
            XCTAssertEqual("A", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsInString() {

        let parserUnderTest = character(isInString: "ABC")

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "B") {
            XCTAssertEqual("B", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "AB") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("B", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "Atail") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpectedToken.token))
            XCTAssertEqual("ottoken", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpectedToken.token))
            XCTAssertEqual("A", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    // MARK: Allow any character to pass.

    func testAnyCharacter() {

        let parserUnderTest = anyCharacter

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if let results = CPTHelpers.run(parser: parserUnderTest, with: "Atail") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

}
