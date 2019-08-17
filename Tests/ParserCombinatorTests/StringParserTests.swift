//
//  StringParserTests.swift
//  ParserCombinator
//
//  Created by Liam on 23/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class StringParserTests: XCTestCase {

    func testUppercaseString() {

        let parserUnderTest = uppercaseString

        if case .success(let results) = parserUnderTest.run(withInput: "ABC") {
            XCTAssertEqual("ABC", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ABCd") {
            XCTAssertEqual("ABC", results.result)
            XCTAssertEqual("d", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "aBCD") {
            XCTAssertEqual("a", unexpected.token)
            XCTAssertEqual("BCD", unexpected.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testLowercaseString() {

        let parserUnderTest = lowercaseString

        if case .success(let results) = parserUnderTest.run(withInput: "abc") {
            XCTAssertEqual("abc", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abcD") {
            XCTAssertEqual("abc", results.result)
            XCTAssertEqual("D", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "Abcd") {
            XCTAssertEqual("A", unexpected.token)
            XCTAssertEqual("bcd", unexpected.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testAlphanumericString() {

        let parserUnderTest = alphanumericString

        if case .success(let results) = parserUnderTest.run(withInput: "aB3") {
            XCTAssertEqual("aB3", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "aB3£") {
            XCTAssertEqual("aB3", results.result)
            XCTAssertEqual("£", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "£Ab3") {
            XCTAssertEqual("£", unexpected.token)
            XCTAssertEqual("Ab3", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

    func testStringWithCharactersInSet() {

        let parserUnderTest = string(withCharactersInSet: .decimalDigits)

        if case .success(let results) = parserUnderTest.run(withInput: "123") {
            XCTAssertEqual("123", results.result)
            XCTAssertEqual("", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if case .success(let results) = parserUnderTest.run(withInput: "123d") {
            XCTAssertEqual("123", results.result)
            XCTAssertEqual("d", results.tail)
        } else {
            XCTFail("The parser should succeed")
        }

        if let unexpected = ParserTestHelper.findUnexpectedToken(running: fullstop, with: "a123") {
            XCTAssertEqual("a", unexpected.token)
            XCTAssertEqual("123", unexpected.tail)
        } else {
            XCTFail("The parser should find an unexpected token")
        }

        XCTAssert(ParserTestHelper.hasInsufficiantTokens(parser: parserUnderTest))
    }

}
