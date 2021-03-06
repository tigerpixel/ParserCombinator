//
//  StringParsers.swift
//  ParserCombinator
//
//  Created by Liam on 22/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//
import Foundation

/// A mapping function to convert an array of characters to a string.
public let toString: ([Character]) -> String = { characters in String(characters) }

/**
 Strings assessed by these composers will be consumed by them and subtracted from the token stream.
 */

/// Only strings comprised exclusively of characters in CharacterSet.uppercaseLetters will pass.
public let uppercaseString = uppercaseLetter.oneOrMany.map(toString)

/// Only strings comprised exclusively of characters in CharacterSet.lowercaseLetters will pass.
public let lowercaseString = lowercaseLetter.oneOrMany.map(toString)

/// Only strings comprised exclusively of characters in CharacterSet.alphanumerics will pass.
public let alphanumericString = alphanumeric.oneOrMany.map(toString)

/// Only strings comprised exclusively of characters in the given characer set will pass.
public func string(withCharactersInSet charSet: CharacterSet) -> Parser<String> {
    (character { charSet.contains($0.unicodeScalar) }).oneOrMany.map(toString)
}
