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
            XCTAssertEqual("ABC", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "ABCd") {
            XCTAssertEqual("ABC", String(results.result))
            XCTAssertEqual("d", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "aBCD") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("BCD", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testLowercaseString() {

        let parserUnderTest = lowercaseString

        if case .success(let results) = parserUnderTest.run(withInput: "abc") {
            XCTAssertEqual("abc", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "abcD") {
            XCTAssertEqual("abc", String(results.result))
            XCTAssertEqual("D", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "Abcd") {
            XCTAssertEqual("A", String(unexpectedToken.token))
            XCTAssertEqual("bcd", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testAlphanumericString() {

        let parserUnderTest = alphanumericString

        if case .success(let results) = parserUnderTest.run(withInput: "aB3") {
            XCTAssertEqual("aB3", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "aB3£") {
            XCTAssertEqual("aB3", String(results.result))
            XCTAssertEqual("£", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "£Ab3") {
            XCTAssertEqual("£", String(unexpectedToken.token))
            XCTAssertEqual("Ab3", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

    func testStringWithCharactersInSet() {

        let parserUnderTest = string(withCharactersInSet: .decimalDigits)

        if case .success(let results) = parserUnderTest.run(withInput: "123") {
            XCTAssertEqual("123", String(results.result))
            XCTAssertEqual("", String(results.tail))
        } else {
            XCTFail()
        }

        if case .success(let results) = parserUnderTest.run(withInput: "123d") {
            XCTAssertEqual("123", String(results.result))
            XCTAssertEqual("d", String(results.tail))
        } else {
            XCTFail()
        }

        if let unexpectedToken = ParserFailureHelpers.expectUnexpectedToken(parser: fullstop, with: "a123") {
            XCTAssertEqual("a", String(unexpectedToken.token))
            XCTAssertEqual("123", String(unexpectedToken.tail))
        } else {
            XCTFail()
        }

        XCTAssert(ParserFailureHelpers.expectInsufficiantCharacters(parser: parserUnderTest))
    }

}
