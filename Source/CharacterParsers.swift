//
//  CharacterParsers.swift
//  ParserCombinator
//
//  Created by Liam on 18/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

// MARK: A convienience method to make a parser for type "Character".

/**
 A convienience method to make a parser for type "Character".
 
 A simple closure is supplied which describes a boolean result of if a character should match. 
 The parser runs the closure and uses it to assess if the character is successful.
 The character assessed by the composer will be consumed by it and subtracted from the token stream.
 
 - parameter condition: A closure which takes the character and returns a boolean result of its is parsability.
 
 - returns: The parser with the same semantic as the closure given.
 */

public func character(condition: @escaping (Character) -> Bool) -> Parser<Character> {

    return Parser { stream in

        guard let character = stream.first else {
            return .failure(details: .insufficiantTokens)
        }

        let tail = stream.dropFirst()

        guard condition(character) else {

            return .failure(details: .unexpectedToken(token: character.tokenized(), tail: tail))
        }

        // Drop first element so that the parser moves on from the current character.
        return .success(result: character, tail: tail)
    }
}

// MARK: Pre-made pasers using the character parser function for defining sets of common characters.

/**
 A convienience method to make a parser with a CharacterSet.
 
 All characters found in the character set will pass, all others will fail.
 The character assessed by the composer will be consumed by it and subtracted from the token stream.
 
 - parameter isInCharacterSet: A character set to which the character should belong.
 
 - returns: The parser whith the same semantic as the character set given.
 */
public func character(isInCharacterSet charSet: CharacterSet) -> Parser<Character> {
    return character { charSet.contains($0.unicodeScalar) }
}

/**
 A convienience method to make a parser which only accepts a sinlge Character.
 
 Only the given character will pass, all others will fail.
 The character assessed by the composer will be consumed by it and subtracted from the token stream.
 
 - parameter isEqualTo: The character which is indented to pass.
 
 - returns: The parser which will only allow the given character to pass, all others will fail.
 */
public func character(isEqualTo token: Character) -> Parser<Character> {
    return character { $0 == token }
}

/**
 A convienience method to make a parser with a string.
 
 Only characters contained in the string will pass, all others will fail.
 The character assessed by the composer will be consumed by it and subtracted from the token stream.
 
 - parameter isInString: The string containing the characters which should be accepted.
 
 - returns: The parser which will only allow the given characters to pass, all others will fail.
 */
public func character(isInString string: String) -> Parser<Character> {
    return character { string.characters.contains($0) }
}

// MARK: Pre-made pasers using the character parser function for common sets of characters.

/// All characters will return a successful result.
public let anyCharacter = character { _ in true}

/// All characters found in CharacterSet.letters will pass, all others will fail.
public let letter = character(isInCharacterSet: .letters)

/// All characters found in CharacterSet.lowercaseLetters will pass, all others will fail.
public let lowercaseLetter = character(isInCharacterSet: .lowercaseLetters)

/// All characters found in CharacterSet.uppercaseLetters will pass, all others will fail.
public let uppercaseLetter = character(isInCharacterSet: .uppercaseLetters)

/// All characters found in CharacterSet.alphanumerics will pass, all others will fail.
public let alphanumeric = character(isInCharacterSet: .alphanumerics)

/// All characters found in CharacterSet.decimalDigits will pass, all others will fail.
public let digit = character(isInCharacterSet: .decimalDigits)

/// All characters found in CharacterSet.whitespaces will pass, all others will fail.
public let whitespace = character(isInCharacterSet: .whitespaces)

/// All characters found in CharacterSet.newlines will pass, all others will fail.
public let newline = character(isInCharacterSet: .newlines)

/// All characters found in CharacterSet.whitespacesAndNewlines will pass, all others will fail.
public let whitespaceOrNewline = character(isInCharacterSet: .whitespacesAndNewlines)

// MARK: Pre-made pasers using the character parser function for single everyday characters.

/// Only the comma character will pass, all others will fail.
public let comma = character(isEqualTo:",")

/// Only the full-stop character will pass, all others will fail.
public let fullstop = character(isEqualTo:".")
