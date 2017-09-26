//
//  ParserOperatorTests+Combinations.swift
//  ParserCombinator
//
//  Created by Liam on 24/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParserOperatorPlusCombinationsTests: XCTestCase {

    // MARK: Create a simple parser which uses all of the operators in combination and test it.

    private func createAllOperatorsParser() -> Parser<String> {

        func curriedFunction(first: Character) -> (Character?) -> (Character) -> String {
            return { second in { third in
                let secondOrEmpty: Character = second ?? Character("-")
                return "fun" + String(first) + String(secondOrEmpty) + String(third)
                }
            }
        }

        let a = ParserTestHelper.characterOrFailureParser(with: "a")
        let b = ParserTestHelper.optionalCharacterParser(with: "b")
        let c = ParserTestHelper.characterOrFailureParser(with: "c")
        let d = ParserTestHelper.characterOrFailureParser(with: "d")
        let e = ParserTestHelper.characterOrFailureParser(with: "e")
        let f = ParserTestHelper.characterOrFailureParser(with: "f")

        /* Parse "a" then optionally "b" into curriedFunction as the first 2 parameters.
         For the final parameter...
            it must parse "c" then "d" but only "c" sould be passed in
         OR it must parse "e" then "f" but only "f" sould be passed in. 
         
         The function returns "fun" followed by the character params or "-" for optional nil*/

        return curriedFunction <^> a <?> b <*> c <* d <|> e *> f
    }

    // MARK: Test combinations of operators.

    func testOperatorPresendenceWithSuccessCombinations() {

        let parserUnderTest = createAllOperatorsParser()

        // Test left side of OR is acceptable.

        if case .success(let results) = parserUnderTest.run(withInput: "abcd") {
            XCTAssertEqual("funabc", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "acd") {
            XCTAssertEqual("funa-c", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        // Test right side of OR is acceptable.

        if case .success(let results) = parserUnderTest.run(withInput: "abef") {
            XCTAssertEqual("funabf", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "aef") {
            XCTAssertEqual("funa-f", results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail("The parser should succeed")
        }
    }

    func testOperatorPresendenceWithInsufficientTokens() {

        let parserUnderTest = createAllOperatorsParser()

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "ab"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testOperatorPresendenceWhenMissingDiscardedCondition() {

        let parserUnderTest = createAllOperatorsParser()

        // NOTE: It could be argued that an insufficient tokens response is more appropriate here.
        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "abc") {
            XCTAssertEqual("c", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "ac") {
            XCTAssertEqual("c", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "abd") {
            XCTAssertEqual("d", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "ad") {
            XCTAssertEqual("d", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "abf") {
            XCTAssertEqual("f", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "af") {
            XCTAssertEqual("f", String(unexpected.token))
            XCTAssertEqual("", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "abe"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "ae"))
    }

    func testOperationalBIsReplacedByADifferentCharacter() {

        let parserUnderTest = createAllOperatorsParser()

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "axcd") {
            XCTAssertEqual("x", String(unexpected.token))
            XCTAssertEqual("cd", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "aacd") {
            XCTAssertEqual("a", String(unexpected.token))
            XCTAssertEqual("cd", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "adcd") {
            XCTAssertEqual("d", String(unexpected.token))
            XCTAssertEqual("cd", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: parserUnderTest, with: "a#ef") {
            XCTAssertEqual("#", String(unexpected.token))
            XCTAssertEqual("ef", String(unexpected.tail))
        } else {
            XCTFail("The parser should find an unexpected token")
        }
    }

}
