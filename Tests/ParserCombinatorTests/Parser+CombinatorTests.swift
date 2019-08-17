//
//  Parser+CombinatorTests.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

private let testParseAToTrue = ParserTestHelper.characterAtoTrueParser()

class ParserPlusCombinatorTests: XCTestCase {

    func testFollowedByParser() {

        let parserUnderTest = testParseAToTrue.followed(by: testParseAToTrue)

        if case .success(let results) = parserUnderTest.run(withInput: "aa") {
            XCTAssertEqual(true, results.result.0)
            XCTAssertEqual(true, results.result.1)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ab") {
            XCTAssertEqual(true, results.result.0)
            XCTAssertEqual(false, results.result.1)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ba") {
            XCTAssertEqual(false, results.result.0)
            XCTAssertEqual(true, results.result.1)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "bb") {
            XCTAssertEqual(false, results.result.0)
            XCTAssertEqual(false, results.result.1)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
    }

    func testMakeOptionalParser() {

        let parserUnderTest = testParseAToTrue.optional

        if case .success(let results) = parserUnderTest.run(withInput: "aaa") {
            XCTAssertEqual(true, results.result)
            XCTAssertEqual("aa", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual(true, results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        // Succeeds even if not present as is optional.
        if case .success(let results) = parserUnderTest.run(withInput: "") {
            XCTAssertEqual(nil, results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }
    }

    func testOneOrManyMatchesParser() {

        let parserUnderTest = testParseAToTrue.oneOrMany

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual([true], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abab") {
            XCTAssertEqual([true, false, true, false], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: ""))
    }

    func testZeroOneOrManyMatchesParser() {

        let parserUnderTest = testParseAToTrue.zeroOneOrMany

        if case .success(let results) = parserUnderTest.run(withInput: "a") {
            XCTAssertEqual([true], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abab") {
            XCTAssertEqual([true, false, true, false], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "") {
            XCTAssertEqual([], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }
    }

    func testRepeatsGivenNumberOfTimesParser() {

        let parserUnderTest = testParseAToTrue.repeats(times: 3)

        // The following two tests look for both different inputs and behaviour over multiple runs. (ie do counts reset)
        if case .success(let results) = parserUnderTest.run(withInput: "aba") {
            XCTAssertEqual([true, false, true], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "baa") {
            XCTAssertEqual([false, true, true], results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ababa") {
            XCTAssertEqual([true, false, true], results.result)
            XCTAssertEqual("ba", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "ab"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: "a"))
        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest, with: ""))
    }

}
