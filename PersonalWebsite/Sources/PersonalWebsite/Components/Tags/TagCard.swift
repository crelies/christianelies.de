//
//  TagCard.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot

extension Node where Context: HTML.BodyContext {
    static func tagCard(headerIcon: Icon, headerIconSize: FontSize, headerTitle: String, additionalHeaderIconClasses: [String], tags: [String]) -> Self {
        let headerIconClasses = [headerIcon.cssClass, headerIconSize.cssClass] + additionalHeaderIconClasses
        let headerIconClass = headerIconClasses.joined(separator: " ")
        return .div(
            .class("card \(TextColor.white.cssClass) bg-dark mb-3 card-size"),
            .div(
                .class("card-header"),
                .span(
                    .i(.class(headerIconClass)),
                    .text(headerTitle))),
            .div(
                .class("card-body"),
                .forEach(tags) { tag in
                    .tag(tag, additionalCssClasses: ["pt-2", "pb-2", "mr-4", "mb-2"])
                }
            )
        )
    }
}
