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
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "b") {
            XCTAssertEqual("b", results.result)
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

        if case .success(let results) = parserUnderTest.run(withInput: "A1234") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("1234", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "1234") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual("234", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "1") {
            XCTAssertEqual("1", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsLoweraseLetter() {

        let parserUnderTest = lowercaseLetter

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("b", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "aBCD") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("BCD", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "Abcd") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("bcd", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsUppercaseLetter() {

        let parserUnderTest = uppercaseLetter

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
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

        if case .success(let results) = parserUnderTest.run(withInput: "Abcd") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("bcd", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "aBCD") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("BCD", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "a") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsAlphanumeric() {

        let parserUnderTest = alphanumeric

        if case .success(let results) = parserUnderTest.run(withInput: "A") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "A1") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("1", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "A#$%") {
            XCTAssertEqual("A", results.result)
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#BCD") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("BCD", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsDigit() {

        let parserUnderTest = digit

        if case .success(let results) = parserUnderTest.run(withInput: "1") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "1#$%") {
            XCTAssertEqual("1", results.result)
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#123") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("123", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))

    }

    func testCharacterIsWhitespace() {

        let parserUnderTest = whitespace

        if case .success(let results) = parserUnderTest.run(withInput: " ") {
            XCTAssertEqual(" ", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: " #$%") {
            XCTAssertEqual(" ", results.result)
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#   ") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("   ", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testCharacterIsNewline() {
        let parserUnderTest = newline

        if case .success(let results) = parserUnderTest.run(withInput: "\n") {
            XCTAssertEqual("\n", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n#$%") {
            XCTAssertEqual("\n", results.result)
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#\n") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("\n", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))

    }

    func testCharacterIsWhitespaceOrNewline() {
        let parserUnderTest = whitespaceOrNewline

        if case .success(let results) = parserUnderTest.run(withInput: " ") {
            XCTAssertEqual(" ", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n") {
            XCTAssertEqual("\n", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "\n#$%") {
            XCTAssertEqual("\n", results.result)
            XCTAssertEqual("#$%", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "#\n ") {
            XCTAssertEqual("#", String(unexpectedToken.token))
            XCTAssertEqual("\n ", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: parserUnderTest, with: "A") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

}
