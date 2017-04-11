//
//  Parser+Run.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 The Parser operates on Character Views. 
 These convenience methods take strings for ease of running.
*/
public extension Parser {

    /**
     Enact a single run of the parser on a subject string.
     
     Hides the use of input tokens and is preferred to calling parse directly.
     
     - parameter input: The pre-parsed subject of the parsing operation.
     
     - returns: A parse result containing the full generic result of the parse.
     */

    func run(withInput input: String) -> ParseResult<Output> {
        return parse(input.characters)
    }

    /**
     Enact a single run of the parser on a subject string. 
     
     Hides the use of input character tokens and is preferred to calling parse directly.
     
     - parameter input: The pre-parsed subject of the parsing operation.
     
     - returns: The successfully parsed object if it is successful.
     Resolves to the optional .none if parsing fails.
     */

    func runAndResolve(withInput input: String) -> Output? {

        guard case .success(let result, _) = parse(input.characters) else {
            return nil
        }

        return result
    }

}
