//
//  IconTextCard.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot

extension Node where Context: HTML.BodyContext {
    static func iconTextCard(headerTitle: String, icon: Icon, iconSize: FontSize, title: String, text: String, additionalCssClasses: [String]) -> Self {
        let allCssClasses = [icon.cssClass, iconSize.cssClass] + additionalCssClasses
        return .div(
            .class("card \(TextColor.white.cssClass) bg-dark mb-3 card-size"),
            .div(
                .class("card-header"),
                .span(
                    .i(.class(allCssClasses.joined(separator: " "))),
                    .text(headerTitle))),
            .div(
                .class("card-body"),
                .h5(.class("card-title"), .text(title)),
                .p(.class("card-text"), .text(text)))
        )
    }
}
