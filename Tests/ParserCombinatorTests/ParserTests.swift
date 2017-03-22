//
//  ParserTests.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParserTests: XCTestCase {

    // MARK: A simple test parser. Checks for a value of "a" and moves on one character.

    private func createTestParser() -> Parser<Bool> {

        return Parser { stream in

            guard let character = stream.first else {
                return .failure(details: .insufficiantTokens)
            }

            let result: Bool = (character == "a")
            // Need to drop first element so tht the parser moves on.
            return .success(result: result, tail: stream.dropFirst())
        }
    }

    // MARK: Test methods which convert one type of parser to another.

    func testMapParser() {

        // Boolean result of mapped to the strings 'true' and 'false'.
        let parserUnderTest = createTestParser().map { $0 ? "true" : "false" }

        if case .success(let results) = parserUnderTest.run(withInput: "aaa") {
            XCTAssertEqual("true", results.result)
            XCTAssertEqual("aa", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "sss") {
            XCTAssertEqual("false", results.result)
            XCTAssertEqual("ss", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testFollowedByParser() {

        let parserUnderTest = createTestParser().followed(by: createTestParser())

        if case .success(let results) = parserUnderTest.run(withInput: "aa") {
            XCTAssertEqual(true, results.result.0)
            XCTAssertEqual(true, results.result.1)
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual(true, results.result.0)
            XCTAssertEqual(false, results.result.1)
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ba") {
            XCTAssertEqual(false, results.result.0)
            XCTAssertEqual(true, results.result.1)
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "bb") {
            XCTAssertEqual(false, results.result.0)
            XCTAssertEqual(false, results.result.1)
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest, withTokens: "a"))
    }

    func testMakeOptionalParser() {

        let parserUnderTest = createTestParser().optional

        if case .success(let results) = parserUnderTest.run(withInput: "aaa") {
            XCTAssertEqual(true, results.result)
            XCTAssertEqual("aa", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual(true, results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "") {
            XCTAssertEqual(nil, results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }
    }

    func testOneOrManyMatchesParser() {

        let parserUnderTest = createTestParser().oneOrMany

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual([true], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abab") {
            XCTAssertEqual([true, false, true, false], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testZeroOneOrManyMatchesParser() {

        let parserUnderTest = createTestParser().zeroOneOrMany

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual([true], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abab") {
            XCTAssertEqual([true, false, true, false], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "") {
            XCTAssertEqual([], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }
    }

    func testRepeatsGivenNumberOfTimesParser() {

        let parserUnderTest = createTestParser().repeats(times: 3)

        // The following two tests look for both different inputs and behaviour over multiple runs. (ie do counts reset)
        if case .success(let results) = parserUnderTest.run(withInput: "aba") {
            XCTAssertEqual([true, false, true], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "baa") {
            XCTAssertEqual([false, true, true], results.result)
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ababa") {
            XCTAssertEqual([true, false, true], results.result)
            XCTAssertEqual("ba", String(results.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest, withTokens: "ab"))
        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest, withTokens: "a"))
        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

}
