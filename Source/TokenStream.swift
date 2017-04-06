//
//  TokenStream.swift
//  ParserCombinator
//
//  Created by Liam on 15/02/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/**
 A parser operates on the Strings character view for efficiency.
 
 The type is regularly used and so a typealias is required.
 
 In parser terms each character is a token.
 */

public typealias TokenStream = String.CharacterView

extension Character {

    func tokenized() -> TokenStream {
        return String(self).characters
    }

}
