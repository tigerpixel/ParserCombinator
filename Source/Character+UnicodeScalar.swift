//
//  Character+UnicodeScalar.swift
//  ParserCombinator
//
//  Created by Liam on 18/03/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

extension Character {

    var unicodeScalar: UnicodeScalar {
        return String(self).unicodeScalars.first!
    }

}
