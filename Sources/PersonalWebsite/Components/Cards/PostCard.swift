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
            .class("card mb-4 card-size list-entry post"),
            .div(
                .class("card-body"),
                .div(
                    .class("card-title list-entry post title"),
                    .h5(.a(
                        .class("list-entry post title link"),
                        .href(item.path),
                        .text(item.title))),
                    .forEach(item.tags) { tag in
                        .linkTag(site: site, tag, fontSize: .small, color: tag.color)
                    }
                ),
                .p(.class("card-text list-entry post description"), .text(item.description)),
                .p(.class("mb-0 list-entry post date"), .text(DateFormatters.post.string(from: item.date)))
            )
        )
    }
}
