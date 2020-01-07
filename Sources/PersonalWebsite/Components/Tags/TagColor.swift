//
//  TagColor.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

enum TagColor {
    case blue
    case gray
    case green
    case red
    case yellow
    case cyan
    case white
    case black
}

extension TagColor {
    var cssClass: String {
        switch self {
        case .blue:
            return "badge-primary"
        case .gray:
            return "badge-secondary"
        case .green:
            return "badge-success"
        case .red:
            return "badge-danger"
        case .yellow:
            return "badge-warning"
        case .cyan:
            return "badge-info"
        case .white:
            return "badge-light"
        case .black:
            return "badge-dark"
        }
    }
}
