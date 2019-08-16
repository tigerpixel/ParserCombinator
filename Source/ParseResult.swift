//
//  ParseResult.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 A result type for a single parse operation.
 
 - success: A successful parse operation containing the result. 
 The tail is any characters which are left unparsed.
 
 - failure: A failed parse operation. Further information is given by the details.
 */

public enum ParseResult<Output> {
    // swiftlint:disable identifier_name // Triggers a false positive in swift lint.
    case success(result: Output, tail: Substring)
    case failure(details: ParseFailure)
    // swiftlint:enable identifier_name
}

/**
 Map the success result output from one type to another. Adding map ensures it is a functor.
 
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
    // swiftlint:disable identifier_name // Triggers a false positive in swift lint.
    case unexpectedToken(token: Character, tail: Substring)
    case custom(message: String)
    // swiftlint:enable identifier_name
}

/**
 Equality

 The failure case type should match.
 If it is custom type then the message must match.
 */

public func == (left: ParseFailure, right: ParseFailure) -> Bool {

    switch(left, right) {
    case (.insufficiantTokens, .insufficiantTokens):
        return true
    case (.unexpectedToken(let leftToken, let leftTail), .unexpectedToken(let rightToken, let rightTail)):
        return leftToken == rightToken && leftTail == rightTail
    case (.custom(let leftMesage), .custom(let rightMessage)):
        return leftMesage == rightMessage
    default:
        return false
    }
}
