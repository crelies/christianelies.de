//
//  LinkTag.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    static func linkTag(site: PersonalWebsite, _ tag: Tag, fontSize: FontSize = .medium, color: TagColor = .cyan) -> Self {
        .a(
            .href(site.url(for: tag)),
            .tag(tag.string, fontSize: fontSize, color: color, additionalCssClasses: ["pt-2", "pb-2", "mr-2", "mb-2"])
        )
    }
}
