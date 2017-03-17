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
 A description of a failed parsing operation.
 
 - insufficiantTokens: There are not enough character tokens remaining to assess the parsing operation.
 - custom: Used to convey custom parse failures when creating custom parsers.
 */

public enum ParseFailure: Equatable {

    case insufficiantTokens
    case custom(message: String)

}

public func == (left: ParseFailure, right: ParseFailure) -> Bool {

    switch(left, right) {
    case (.insufficiantTokens, .insufficiantTokens):
        return true
    case (.custom(let leftMesage), .custom(let rightMessage)):
        return leftMesage == rightMessage
    default:
        return false
    }
}
