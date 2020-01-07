//
//  FontSize.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

enum FontSize {
    case small
    case medium
    case large
    case display
}

extension FontSize {
    var cssClass: String {
        switch self {
        case .small:
            return "fs-12"
        case .medium:
            return "fs-14"
        case .large:
            return "fs-18"
        case .display:
            return "fs-32"
        }
    }
}
