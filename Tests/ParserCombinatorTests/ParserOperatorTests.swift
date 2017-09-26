//
//  ParserOperatorTests.swift
//  ParserCombinator
//
//  Created by Liam on 24/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParserOperatorTests: XCTestCase {

    // MARK: Test the functionlity of single operators.

    func testSequentialApplicationOperator() {

        func twice(character: Character) -> String {
            return String(character) + String(character)
        }

        // A parser where the result is a function.
        let function = Parser { .success(result: twice, tail: $0) }
        let a = ParserTestHelper.characterOrFailureParser(with: "a")

        let parserUnderTest = function <*> a // Result of "function" parser with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", String(unexpected.token))
            XCTAssertEqual("ba", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testOptionalSequentialApplicationOperator() {

        func twice(character: Character?) -> String {
            if let character = character {
                return String(character) + String(character)

            }
            return ""
        }

        // A parser where the result is a function.
        let function = Parser { .success(result: twice, tail: $0) }
        let a: Parser<Character?> = ParserTestHelper.optionalCharacterParser(with: "a")

        let parserUnderTest = function <?> a // Result of "function" parser with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "cba") {
            XCTAssertEqual("", results.result)
            XCTAssertEqual("cba", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testFMapCombinatorOperator() {

        func twice(character: Character) -> String {
            return String(character) + String(character)
        }

        let a = ParserTestHelper.characterOrFailureParser(with: "a")

        let parserUnderTest = twice <^> a // Result of "function" with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", String(unexpected.token))
            XCTAssertEqual("ba", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }
    }

    func testOrOperator() {

        let a = ParserTestHelper.characterOrFailureParser(with: "a")
        let b = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = a <|> b // "a" or "b"

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "b") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", String(unexpected.token))
            XCTAssertEqual("ba", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testDiscardFirstOperator() {

        let a = ParserTestHelper.characterOrFailureParser(with: "a")
        let b = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = a *> b // Check "a" followed by "b", but then only return "b"

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abtail") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "aad") {
            XCTAssertEqual("a", String(unexpected.token))
            XCTAssertEqual("d", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "bad") {
            XCTAssertEqual("b", String(unexpected.token))
            XCTAssertEqual("ad", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "b") {
            XCTAssertEqual("b", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testDiscardSecondOperator() {

        let a = ParserTestHelper.characterOrFailureParser(with: "a")
        let b = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = a <* b // Check "a" followed by "b", but then only return "a"

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abtail") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("tail", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "aad") {
            XCTAssertEqual("a", String(unexpected.token))
            XCTAssertEqual("d", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "bad") {
            XCTAssertEqual("b", String(unexpected.token))
            XCTAssertEqual("ad", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "b") {
            XCTAssertEqual("b", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
