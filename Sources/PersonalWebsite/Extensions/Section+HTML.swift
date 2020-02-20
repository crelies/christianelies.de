//
//  Section+HTML.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot
import Publish

extension Section where Site == PersonalWebsite {
    private func me(context: PublishingContext<Site>) -> HTML {
        HTML(
            .head(for: self, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body(
                .customHeader(context: context, currentSectionID: .me),
                .div(
                    .class("page-wrapper container \(TextColor.white.cssClass)"),

                    .h2(.class("mb-3"),
                        "About me"),

                    .div(
                        .class("row"),

                        .div(
                            .class("col me card-wrapper"),
                            .iconTextCard(
                                headerTitle: "Current position",
                                icon: .laptop,
                                iconSize: .display,
                                title: "iOS Software Engineer @eos-uptrade",
                                text: "I work in the Hamburg office. My team is among others responsible for the library eos.ticketingSuite.",
                                additionalCssClasses: ["mr-2"])
                        ),

                        .div(
                            .class("col me card-wrapper"),
                            .tagCard(headerIcon: .user,
                                     headerIconSize: .display,
                                     headerTitle: "Personal tags",
                                     additionalHeaderIconClasses: ["mr-2"],
                                     tags: ["Family person",
                                            "Minimalist",
                                            "Traveler 4731: I love to travel",
                                            "Skier",
                                            "Father",
                                            "Road racer",
                                            "Swift developer"])
                        )
                    )
                ),
                .customFooter()
            )
        )
    }

    private func posts(context: PublishingContext<Site>) -> HTML {
        HTML(
            .head(for: self, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body(
                .customHeader(context: context, currentSectionID: .posts),
                .div(
                    .class("page-wrapper container \(TextColor.white.cssClass)"),

                    .h2(.class("mb-3"),
                        "Posts"),

                    .forEach(items) { item in
                        .postCard(site: context.site, item: item)
                    }
                ),
                .customFooter()
            )
        )
    }

    private func projects(context: PublishingContext<Site>) -> HTML {
        HTML(
            .head(for: self, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body(
                .customHeader(context: context, currentSectionID: .projects),
                .div(
                    .class("page-wrapper container \(TextColor.white.cssClass)"),
                    .h2(.class("mb-3"),
                        "Projects"),
                    .p("Coming soon ...")
                ),
                .customFooter()
            )
        )
    }

    func html(context: PublishingContext<Site>) -> HTML {
        switch id {
        case .me:
            return me(context: context)
        case .posts:
            return posts(context: context)
        case .projects:
            return projects(context: context)
        }
    }
}
