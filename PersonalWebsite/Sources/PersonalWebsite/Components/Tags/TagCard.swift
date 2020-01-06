//
//  TagCard.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot

extension Node where Context: HTML.BodyContext {
    static func tagCard(headerTitle: String, headerIconClass: String, items: [String]) -> Self {
        .div(
            .class("card \(TextColor.white.cssClass) bg-dark mb-3 card-size"),
            .div(
                .class("card-header"),
                .span(.i(.class(headerIconClass)),
                      .text(headerTitle))
            ),
            .div(
                .class("card-body"),
                .forEach(items) { item in
                    .tag(item, additionalCssClasses: ["pt-2", "pb-2", "mr-4", "mb-2"])
                }
            )
        )
    }
}
