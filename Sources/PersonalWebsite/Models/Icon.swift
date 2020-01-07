//
//  Icon.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

enum Icon {
    case github
    case laptop
    case linkedin
    case medium
    case stackoverflow
    case user
    case xing
}

extension Icon {
    var cssClass: String {
        switch self {
        case .github:
            return "fab fa-github"
        case .laptop:
            return "fas fa-laptop-code"
        case .linkedin:
            return "fab fa-linkedin"
        case .medium:
            return "fab fa-medium"
        case .stackoverflow:
            return "fab fa-stack-overflow"
        case .user:
            return "fas fa-user"
        case .xing:
            return "fab fa-xing"
        }
    }
}
