//
//  StringParsers.swift
//  ParserCombinator
//
//  Created by Liam on 22/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/// A mapping function to convert an array of characters to a string.
private let toString: ([Character]) -> String = { characters in String(characters) }

/// A string comprising of at least one character in CharacterSet.uppercaseLetters will pass, all others will fail.
public let uppercaseString = uppercaseLetter.oneOrMany.map(toString)

/// A string comprising of at least one character in CharacterSet.lowercaseLetters will pass, all others will fail.
public let lowercaseString = lowercaseLetter.oneOrMany.map(toString)

/// A string comprising of at least one character in CharacterSet.alphanumerics will pass, all others will fail.
public let alphanumericString = alphanumeric.oneOrMany.map(toString)

/// A string comprising of at least one character in the given characer set will pass, all others will fail.
public func string(withCharactersInSet charSet: CharacterSet) -> Parser<String> {
    return (character { charSet.contains($0.unicodeScalar) }).oneOrMany.map(toString)
}
