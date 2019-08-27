//
//  NumberParsers.swift
//  ParserCombinator
//
//  Created by Liam on 23/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/// A set of tokens describing an integer number. The number can consist of one or more digits.
public let integerNumber = digit.oneOrMany.map { characterArray -> Int in

    Int(String(characterArray)) ?? 0
}
