//
//  Tag+color.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Publish

extension Tag {
    var color: TagColor {
        guard let firstCharacter = string.first else { return .cyan }

        switch firstCharacter {
        case (Character("a")...Character("c")):
            return .blue
        case (Character("d")...Character("o")):
            return .green
        case (Character("p")...Character("t")):
            return .cyan
        case (Character("u")...Character("z")):
            return .red
        default:
            return .cyan
        }
    }
}
