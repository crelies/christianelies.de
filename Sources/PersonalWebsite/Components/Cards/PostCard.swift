//
//  PostCard.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    static func postCard(site: PersonalWebsite, item: Item<PersonalWebsite>) -> Self {
        .div(
            .class("card \(TextColor.white.cssClass) bg-dark mb-3 card-size"),
            .div(
                .class("card-body"),
                .div(
                    .class("card-title"),
                    .h5(.a(
                        .class(TextColor.white.cssClass),
                        .href(item.path),
                        .text(item.title))),
                    .forEach(item.tags) { tag in
                        .linkTag(site: site, tag, fontSize: .small, color: tag.color)
                    }
                ),
                .p(.class("card-text"), .text(item.description)),
                .p(.class("\(TextColor.red.cssClass) mb-0"), .text(DateFormatters.post.string(from: item.date)))
            )
        )
    }
}
