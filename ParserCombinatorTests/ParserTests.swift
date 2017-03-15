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
    
    //MARK: Parser+Run
    
    // A simple test parser. Checks for a value of "a" and moves on one character.
    
    private func createTestParser() -> Parser<Bool> {
        
        return Parser { stream in
            
            guard let character = stream.first else {
                return .failure(details: .insufficiantTokens)
            }
            
            let result: Bool = (character == "a")
            // Need to drop first element so tht the parser moves on.
            return .success(result: result , tail: stream.dropFirst())
        }
        
    }
    
    // MARK: Run and resolve result to optional.
    
    func testRunAndResolveParserWithSuccessMatch() {
        
        let testParser = createTestParser()
        
        let output = testParser.runAndResolve(withInput: "a")
        
        XCTAssertEqual(true, output)
    }
    
    func testRunAndResolveParserWithSuccessMismatch() {
        
        let testParser = createTestParser()
        
        let output = testParser.runAndResolve(withInput: "b")
        
        XCTAssertEqual(false, output)
    }
    
    func testRunAndResolveParserWithNoInputTokens() {
        
        let testParser = createTestParser()
        
        let output = testParser.runAndResolve(withInput: "")
        
        XCTAssertEqual(nil, output)
    }
    
    //MARK: Run and manually resolve result.
    
    func testRunParserWithSuccessMatch() {
        
        let testParser = createTestParser()
        
        let parseResult = testParser.run(withInput: "a")
        
        guard case .success(let result, let tail) = parseResult else {
            XCTFail("Expected success case received \(parseResult).")
            return
        }
        
        XCTAssertEqual(true, result)
        XCTAssertEqual("", String(tail))
    }
    
    func testRunParserWithSuccessMismatch() {
        
        let testParser = createTestParser()
        
        let parseResult = testParser.run(withInput: "b")
        
        guard case .success(let result, let tail) = parseResult else {
            XCTFail("Expected success case received \(parseResult).")
            return
        }
        
        XCTAssertEqual(false, result)
        XCTAssertEqual("", String(tail))
    }
    
    func testRunParserWithNoInputTokens() {
        
        let testParser = createTestParser()
        
        let parseResult = testParser.run(withInput: "")
        
        guard case .failure(let reason) = parseResult else {
            XCTFail("Expected failure case received \(parseResult).")
            return
        }
        
        XCTAssertEqual(ParseFailure.insufficiantTokens, reason)
    }
    
}
