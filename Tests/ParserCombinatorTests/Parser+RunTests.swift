//
//  Parser+RunTests.swift
//  ParserCombinator
//
//  Created by Liam on 22/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import ParserCombinator

class ParserPlusRunTests: XCTestCase {

    // MARK: Run and resolve result to optional.

    func testRunAndResolveParserWithSuccessMatch() {

        let testParser = ParserTestHelper.testAParser()

        let output = testParser.runAndResolve(withInput: "a")

        XCTAssertEqual(true, output)
    }

    func testRunAndResolveParserWithSuccessMismatch() {

        let testParser = ParserTestHelper.testAParser()

        let output = testParser.runAndResolve(withInput: "b")

        XCTAssertEqual(false, output)
    }

    func testRunAndResolveParserWithNoInputTokens() {

        let testParser = ParserTestHelper.testAParser()

        let output = testParser.runAndResolve(withInput: "")

        XCTAssertEqual(nil, output)
    }

    // MARK: Run and manually resolve result.

    func testRunParserWithSuccessMatch() {

        let testParser = ParserTestHelper.testAParser()

        let parseResult = testParser.run(withInput: "a")

        guard case .success(let result, let tail) = parseResult else {
            XCTFail("Expected success case received \(parseResult).")
            return
        }

        XCTAssertEqual(true, result)
        XCTAssertEqual("", String(tail))
    }

    func testRunParserWithSuccessMismatch() {

        let testParser = ParserTestHelper.testAParser()

        let parseResult = testParser.run(withInput: "b")

        guard case .success(let result, let tail) = parseResult else {
            XCTFail("Expected success case received \(parseResult).")
            return
        }

        XCTAssertEqual(false, result)
        XCTAssertEqual("", String(tail))
    }

    func testRunParserWithNoInputTokens() {

        let testParser = ParserTestHelper.testAParser()

        let parseResult = testParser.run(withInput: "")

        guard case .failure(let reason) = parseResult else {
            XCTFail("Expected failure case received \(parseResult).")
            return
        }

        XCTAssertEqual(ParseFailure.insufficiantTokens, reason)
    }

}
