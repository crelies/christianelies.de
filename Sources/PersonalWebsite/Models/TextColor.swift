//
//  TextColor.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

enum TextColor {
    case red
    case white
}

extension TextColor {
    var cssClass: String {
        switch self {
        case .red:
            return "text-danger"
        case .white:
            return "text-white"
        }
    }
}
