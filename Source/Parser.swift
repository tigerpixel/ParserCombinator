//
//  Parser.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 The core generic parser structure that is combined to make the parser combinator.
 */

public struct Parser<Output> {

    ///Consumes zero, one or more tokens and resolve them into a result of the correct type.
    let parse: (TokenStream) -> ParseResult<Output>

}

public extension Parser {

    /**
     Map the parser from one type to another.
     
     - parameter transform: The transform function for the contained type.
     
     - returns: A mapped parser with the updated type.
     */

    func map<MappedOutput>(_ transform: @escaping (Output) -> MappedOutput) -> Parser<MappedOutput> {

        return Parser<MappedOutput> { stream in
            self.parse(stream).map(transform)
        }
    }

    /**
     Combine two parsers to a single parser containing a tuple of the output of each in order.
     
     This parser can be used to check for one token followed by another distinct token.
     
     - parameter by: The additional parser which is to be combined with the current parser.
     
     - returns: A parser containing a tuple of the current and additional types.
     */

    func followed<SecondOutput>(by second: Parser<SecondOutput>) -> Parser<(Output, SecondOutput)> {

        return Parser<(Output, SecondOutput)> { stream in

            switch self.parse(stream) {

            case .success(let firstResult, let firstTail):

                switch second.parse(firstTail) {

                case .success(let secondResult, let secondTail):
                    return .success(result: (firstResult, secondResult), tail: secondTail)

                case .failure(let details):
                    return .failure(details: details)
                }

            case .failure(let details):
                return .failure(details: details)

            }
        }
    }

}

public extension Parser {

    /**
     Optionally parse the token and always return a success even if the token is not present.
     
     - returns: An parser with optional contents which may resolve to a successful nil result.
     */

    var optional: Parser<Output?> {

        return Parser<Output?> { stream in

            let parseResult = self.parse(stream)

            if case .success = parseResult {
                return parseResult.map { Optional($0) }
            }

            return .success(result: nil, tail: stream)
        }
    }

    /**
     Loop the parse function until it fails, giving an array of positive results.
     
     It is not acceptable for there to be zero results, this will cause the parser to fail.
     
     - returns: A parser which, if successful, will contain an array of one or more results.
     */

    var oneOrMany: Parser<[Output]> {

        return Parser<[Output]> { stream in

            let firstResult = self.parse(stream)

            guard case .success(let firstElement, let firstRemainder) =  firstResult else {
                return firstResult.map { [$0] }
            }

            var result: [Output] = [firstElement]
            var remainder = firstRemainder

            while case .success(let element, let newRemainder) =  self.parse(remainder) {

                result.append(element)
                remainder = newRemainder
            }

            return .success(result: result, tail: remainder)
        }
    }

    /**
     Loop the parse function until it fails, giving an array of positive results.
     
     It is acceptable for there to be zero results, this will return an empty array.
     
     - returns: A parser which will produce an array of some or no results.
     */

    var zeroOneOrMany: Parser<[Output]> {

        return Parser<[Output]> { stream in

            var result: [Output] = []
            var remainder = stream

            while case .success(let element, let newRemainder) =  self.parse(remainder) {

                result.append(element)
                remainder = newRemainder
            }

            return .success(result: result, tail: remainder)
        }
    }

    /**
     Loop the parse function until it finds exactly the given number of results.
     
     The results will be combined into an array.
     
     - parameter times: The amount of times the given token must appear for a successful parse to occur.
     
     - returns: A parser which, if successful, will produce an array of exactly the given results.
     */

    func repeats(times: Int) -> Parser<[Output]> {

        return Parser<[Output]> { stream in

            var remaining: Int = times
            var result: [Output] = []
            var remainder = stream

            while
                case .success(let element, let newRemainder) =  self.parse(remainder),
                remaining > 0
            {

                result.append(element)
                remainder = newRemainder

                remaining -= 1
            }

            guard remaining == 0 else {
                return .failure(details: .insufficiantTokens)
            }

            return .success(result: result, tail: remainder)
        }
    }

}
