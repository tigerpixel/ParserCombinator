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

    // MARK: Tests for the convenience method to make a parser for type "Character".

    func testCharacterWithCondition() {

        let parserUnderTest = character { $0 == "A" }

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "AA") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("A", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "Atail") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpected.token))
            XCTAssertEqual("ottoken", String(unexpected.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpected.token))
            XCTAssertEqual("A", String(unexpected.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    // MARK: Tests of pre-made pasers using the character parser function for defining sets of common characters.

    func testCharacterInCharacterSet() {

        let parserUnderTest = character(isInCharacterSet: .decimalDigits)

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "12") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("2", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1tail") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpected.token))
            XCTAssertEqual("ottoken", String(unexpected.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: ",1") {
            XCTAssertEqual(",", String(unexpected.token))
            XCTAssertEqual("1", String(unexpected.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testCharacterEqualTo() {

        let parserUnderTest = character(isEqualTo: "A")

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "AA") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("A", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "Atail") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpected.token))
            XCTAssertEqual("ottoken", String(unexpected.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpected.token))
            XCTAssertEqual("A", String(unexpected.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testCharacterIsInString() {

        let parserUnderTest = character(isInString: "ABC")

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "B") {
            XCTAssertEqual("B", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "AB") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("B", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "Atail") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "nottoken") {
            XCTAssertEqual("n", String(unexpected.token))
            XCTAssertEqual("ottoken", String(unexpected.tail))
        } else {
            XCTFail()
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: ",A") {
            XCTAssertEqual(",", String(unexpected.token))
            XCTAssertEqual("A", String(unexpected.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    // MARK: Allow any character to pass.

    func testAnyCharacter() {

        let parserUnderTest = anyCharacter

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "Atail") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
