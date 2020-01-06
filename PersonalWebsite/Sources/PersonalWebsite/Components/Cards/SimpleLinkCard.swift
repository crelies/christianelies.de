//
//  SimpleLinkCard.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    static func simpleLinkCard(title: String, text: String, path: Path) -> Self {
        .div(
            .class("card \(TextColor.white.cssClass) bg-dark mb-3 card-size"),
            .div(
                .class("card-body"),
                .h5(
                    .class("card-title"),
                    .a(
                        .href(path),
                        .text(title))
                ),
                .p(.class("card-text"), .text(text))
            )
        )
    }
}
