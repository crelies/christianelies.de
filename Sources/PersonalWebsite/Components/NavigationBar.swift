//
//  NavigationBar.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    static func navigationBar(context: PublishingContext<PersonalWebsite>,
                              currentSectionID: PersonalWebsite.SectionID? = nil) -> Self {
        .nav(
            .class("navbar navbar-expand-lg navbar-dark bg-dark justify-content-center"),
            .div(
                .class("navbar-nav"),

                .forEach(context.sections.sorted(by: { $0.id.rawValue < $1.id.rawValue })) { section in
                    var linkClasses = ["nav-item", "nav-link"]
                    if section.id == currentSectionID {
                        linkClasses.append("active")
                    }
                    linkClasses.append(FontSize.large.cssClass)

                    let linkClassString = linkClasses.joined(separator: " ")
                    return .a(.class(linkClassString),
                              .href(context.site.url(for: section.path)),
                              ".\(section.id.rawValue)")
                }
            )
        )
    }
}
