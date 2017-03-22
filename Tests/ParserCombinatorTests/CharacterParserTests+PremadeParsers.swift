//
//  CharacterParserTests+PremadeParsers.swift
//  ParserCombinator
//
//  Created by Liam on 21/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

extension CharacterParserTests {

    // MARK: Tests of pre-made pasers using the character parser function for common sets of characters.

    func testCharacterIsLetter() {

        let parserUnderTest = letter

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "b") {
            XCTAssertEqual("b", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "AB") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("B", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "A1234") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("1234", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "1234") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual("234", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "1") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsLoweraseLetter() {

        let parserUnderTest = lowercaseLetter

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("a", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("a", String(results.result))
            XCTAssertEqual("b", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "aBCD") {
            XCTAssertEqual("a", String(results.result))
            XCTAssertEqual("BCD", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "Abcd") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("bcd", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsUppercaseLetter() {

        let parserUnderTest = uppercaseLetter

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "AB") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("B", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "Abcd") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("bcd", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "aBCD") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("BCD", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "a") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsAlphanumeric() {

        let parserUnderTest = alphanumeric

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "A1") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("1", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "A#$%") {
            XCTAssertEqual("A", String(results.result))
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#BCD") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("BCD", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsDigit() {

        let parserUnderTest = digit

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1#$%") {
            XCTAssertEqual("1", String(results.result))
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#123") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("123", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))

    }

    func testCharacterIsWhitespace() {

        let parserUnderTest = whitespace

        if case .success(let results) = parserUnderTest.run(withInput: " ") {
            XCTAssertEqual(" ", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: " #$%") {
            XCTAssertEqual(" ", String(results.result))
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#   ") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("   ", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsNewline() {
        let parserUnderTest = newline

        if case .success(let results) = parserUnderTest.run(withInput: "\n") {
            XCTAssertEqual("\n", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n#$%") {
            XCTAssertEqual("\n", String(results.result))
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#\n") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("\n", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))

    }

    func testCharacterIsWhitespaceOrNewline() {
        let parserUnderTest = whitespaceOrNewline

        if case .success(let results) = parserUnderTest.run(withInput: " ") {
            XCTAssertEqual(" ", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n") {
            XCTAssertEqual("\n", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n#$%") {
            XCTAssertEqual("\n", String(results.result))
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "#\n ") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("\n ", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = CPTHelpers.runAndExpectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(CPTHelpers.runAndExpectInsufficiantCharacters(parser: parserUnderTest))
    }

}
