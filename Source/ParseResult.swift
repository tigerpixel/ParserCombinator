//
//  ParseResult.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 A result type for a single parse operation.
 
 - success: A successful parse operation containing the result. The tail is any characters left unparsed.
 - failure: A failed parse operation. Further information is given by the details.
 */

public enum ParseResult<Output> {

    case success(result: Output, tail: TokenStream)
    case failure(details: ParseFailure)

}

/**
 Map the success result output from one type to another.
 
 - parameter transform: The transform function for the contained type.
 
 - returns: A mapped version of the parser result.
 */

public extension ParseResult {

    func map<MappedOutput>(_ transform: @escaping (Output) -> MappedOutput) -> ParseResult<MappedOutput> {

        switch self {
        case .success(let result, let remainder):
            return .success(result: transform(result), tail: remainder)
        case .failure(details: let details):
            return .failure(details: details)
        }
    }
}

/**
 A description of a failed parsing operation.
 
 - insufficiantTokens: There are not enough character tokens remaining to assess the parsing operation.
 - custom: Used to convey custom parse failures when creating custom parsers.
 */

public enum ParseFailure: Equatable {

    case insufficiantTokens
    case unexpectedToken(token: TokenStream, tail: TokenStream)
    case custom(message: String)

}

/**
 Equality
 
 The failure should be for the same reason, if it is custom then the messages must match.
 */

public func == (left: ParseFailure, right: ParseFailure) -> Bool {

    switch(left, right) {
    case (.insufficiantTokens, .insufficiantTokens):
        return true
    case (.unexpectedToken(let leftToken, let leftTail), .unexpectedToken(let rightToken, let rightTail)):
        return String(leftToken) == String(rightToken) && String(leftTail) == String(rightTail)
    case (.custom(let leftMesage), .custom(let rightMessage)):
        return leftMesage == rightMessage
    default:
        return false
    }

}
