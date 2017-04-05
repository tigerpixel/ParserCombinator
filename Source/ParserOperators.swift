//
//  ParserCombinatorOperators.swift
//  ParserCombinator
//
//  Created by Liam on 24/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

// Combine multiple parsers so that they run one after the other and produce a combined result.

/**
 Sequential Application Operator (Apply).
 
 Combine multiple parsers so that the function within one is applied to the parameter given within the other parser. The resulting parser is returned.
 
 Discussion: This method is a core concept within the parser conbinator. The first parmeter of this function contains a parser which maps from one type to another. This function is applied to the secondary parameter and the result is returned. Adding this operator means that the parser can be classified as an applicative functor.
 
 - parameter left: A parser which contains a transform function from one type to another.
 
 - parameter right: The parser that is the subject of the transform.
 
 - returns: A parser of the type given after the transform function is complete.
 */

precedencegroup SequentialApplication {
    associativity: left
}

infix operator <*> : SequentialApplication

public func <*> <T, U>(left: Parser<(T) -> U>, right: Parser<T>) ->  Parser<U> {
    return left.followed(by: right).map { f, x in f(x) }
}

/**
 Optional Sequential Application Operator.
 
 Combine multiple parsers so that the function within one is applied to the parameter given within the other parser. The resulting parser is returned. 
 
 Discussion: In the case that an optional nil is sent to the second parameter then this will be mapped to a result.
 
 - parameter left: A parser which contains a transform function from one type to another.
 
 - parameter right: The parser that is the subject of the transform but may contain an optional nil value.
 
 - returns: A parser of the type given after the transform function is complete.
 */

precedencegroup OptionalSequentialApplication {
    higherThan: SequentialApplication
    associativity: left
}

infix operator <?> : OptionalSequentialApplication

public func <?> <T, U>(left: Parser<(T?) -> U>, right: Parser<T?>) ->  Parser<U> {
    return left.followed(by: right).map { f, x in f(x) }
}

/**
 Map Operator
 
 Apply a mapping function to the parser. Creating a parser of a different type. Reverses the syntax of applying a map using a function. The map transform is first, then the value to be mapped.
 
 - parameter left: A parser which contains a transform function from one type to another.
 
 - parameter right: The parser subject of the map.
 
 - returns: A parser of the type given after the map function is applied.
 */

precedencegroup Map {
    higherThan: OptionalSequentialApplication
    associativity: left
}

infix operator <^> : Map

public func <^> <T, U>(left: @escaping (T) -> U, right: Parser<T>) ->  Parser<U> {
    return right.map(left)
}

/**
 Or Operator
 
 Combine two parsers so that when paring occurs, if the first fails the second will be run. Only if the second then fails will an error by returned. The result contained within the first parser to succeed will be returned where possible.
 
 - parameter left: The first parser to be run which may fail.
 
 - parameter right: The parser which will run if the first parser fails.
 
 - returns: The resulting parser which will run one arguement and then anothe rin an 'or' fashion.
 */

precedencegroup Or {
    higherThan: Map
    associativity: left
}

infix operator <|> : Or

public func <|> <T>(left: Parser<T>, right: Parser<T>) ->  Parser<T> {

    return Parser<T> { stream in

        let firstResult = left.parse(stream)

        guard case .success = firstResult else {
            return right.parse(stream)
        }

        return firstResult
    }
}

/**
 Check and Discard First Operator
 
 Parse both left and right operands and check for a success. If there is success on both parsers, discard the result given by the first operator. Return only the result of the second operand.
 
 - parameter left: A parser which will be run and must succeed for the combined parser to succeed by the result of which will not be returned.
 
 - parameter right: A parser which will be run and must succeed. It will provide the result for the combined parser.
 
 - returns: A Parser which will require both parser to succeed but will only return the result of the second. The result of the first parser to fail will be returned in the event of a failure.
 */

precedencegroup DiscardFirst {
    higherThan: Or
    associativity: right
}

infix operator *> : DiscardFirst

public func *> <T, U>(left: Parser<T>, right: Parser<U>) ->  Parser<U> {
    return { _ in { $0 }} <^> left <*> right
}

/**
 Check and Discard Second Operator
 
 Parse both left and right operands and check for a success. If there is success on both parsers, discard the result given by the second operator. Return only the result of the first operand.
 
 - parameter left: A parser which will be run and must succeed. It will provide the result for the combined parser.
 
 - parameter right: A parser which will be run and must succeed for the combined parser to succeed by the result of which will not be returned.
 
 - returns: A Parser which will require both parser to succeed but will only return the result of the first. The result of the first parser to fail will be returned in the event of a failure.
 */

precedencegroup DiscardSecond {
    higherThan: Or
    associativity: left
}

infix operator <* : DiscardSecond

public func <* <T, U>(left: Parser<T>, right: Parser<U>) ->  Parser<T> {
    return { firstContents in { _ in firstContents } } <^> left <*> right
}
