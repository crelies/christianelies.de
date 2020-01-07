//
//  Tag.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot

extension Node where Context: HTML.BodyContext {
    static func tag(_ tag: String,
                    fontSize: FontSize = .medium,
                    color: TagColor = .cyan,
                    additionalCssClasses: [String] = []) -> Self {
        let defaultCssClasses = ["badge",
                                 "badge-pill",
                                 color.cssClass,
                                 fontSize.cssClass,
                                 "text-monospace"]
        let allCssClasses = defaultCssClasses + additionalCssClasses
        let classString = allCssClasses.joined(separator: " ")
        return .span(.class(classString), .text(tag))
    }
}
