//
//  ParserOperatorTests.swift
//  ParserCombinator
//
//  Created by Liam on 24/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

private func twice(character: Character) -> String {
    return String([character, character])
}

class ParserOperatorTests: XCTestCase {

    // MARK: Test the functionlity of single operators.

    func testSequentialApplicationOperator() {

        // A parser where the result is a function.
        let function = Parser { .success(result: twice, tail: $0) }
        let aChar = ParserTestHelper.characterOrFailureParser(with: "a")

        let parserUnderTest = function <*> aChar // Result of "function" parser with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", unexpected.token)
            XCTAssertEqual("ba", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testOptionalSequentialApplicationOperator() {

        func twice(character: Character?) -> String {
            if let character = character {
                return String([character, character])

            }
            return ""
        }

        // A parser where the result is a function.
        let function = Parser { .success(result: twice, tail: $0) }
        let aChar: Parser<Character?> = ParserTestHelper.optionalCharacterParser(with: "a")

        let parserUnderTest = function <?> aChar // Result of "function" parser with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "cba") {
            XCTAssertEqual("", results.result)
            XCTAssertEqual("cba", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testFMapCombinatorOperator() {

        let aChar = ParserTestHelper.characterOrFailureParser(with: "a")

        let parserUnderTest = twice <^> aChar // Result of "function" with "a" applied to it.

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("aa", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", unexpected.token)
            XCTAssertEqual("ba", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }
    }

    func testOrOperator() {

        let aChar = ParserTestHelper.characterOrFailureParser(with: "a")
        let bChar = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = aChar <|> bChar // "a" or "b"

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "b") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "atail") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "cba") {
            XCTAssertEqual("c", unexpected.token)
            XCTAssertEqual("ba", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testDiscardFirstOperator() {

        let aChar = ParserTestHelper.characterOrFailureParser(with: "a")
        let bChar = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = aChar *> bChar // Check "a" followed by "b", but then only return "b"

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abtail") {
            XCTAssertEqual("b", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "aad") {
            XCTAssertEqual("a", unexpected.token)
            XCTAssertEqual("d", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "bad") {
            XCTAssertEqual("b", unexpected.token)
            XCTAssertEqual("ad", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "b") {
            XCTAssertEqual("b", unexpected.token)
            XCTAssertEqual("", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testDiscardSecondOperator() {

        let aChar = ParserTestHelper.characterOrFailureParser(with: "a")
        let bChar = ParserTestHelper.characterOrFailureParser(with: "b")

        let parserUnderTest = aChar <* bChar // Check "a" followed by "b", but then only return "a"

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abtail") {
            XCTAssertEqual("a", results.result)
            XCTAssertEqual("tail", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "aad") {
            XCTAssertEqual("a", unexpected.token)
            XCTAssertEqual("d", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "bad") {
            XCTAssertEqual("b", unexpected.token)
            XCTAssertEqual("ad", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "b") {
            XCTAssertEqual("b", unexpected.token)
            XCTAssertEqual("", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
