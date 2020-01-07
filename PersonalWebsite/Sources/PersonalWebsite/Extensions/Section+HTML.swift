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
    private func me(sections: SectionMap<Site>) -> HTML {
        HTML(
            .customHead(),
            .body(
                .customHeader(sections: sections, currentSectionID: .me),
                .div(
                    .class("page-wrapper container \(TextColor.white.cssClass)"),

                    .h2(.class("mb-3"),
                        "About me"),

                    .div(
                        .class("row"),

                        .div(
                            .class("col"),
                            .iconTextCard(
                                headerTitle: "Current position",
                                icon: .laptop,
                                iconSize: .display,
                                title: "iOS Software Engineer @eos-uptrade",
                                text: "I work in the Hamburg office. My team is among others responsible for the library eos.ticketingSuite.",
                                additionalCssClasses: ["mr-2"])
                        ),

                        .div(
                            .class("col"),
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

    private func posts(sections: SectionMap<Site>) -> HTML {
        HTML(
            .customHead(),
            .body(
                .customHeader(sections: sections, currentSectionID: .posts),
                .div(
                    .class("page-wrapper container \(TextColor.white.cssClass)"),

                    .h2(.class("mb-3"),
                        "Posts"),

                    .forEach(items) { item in
                        .postCard(item: item)
                    }
                ),
                .customFooter()
            )
        )
    }

    private func projects(sections: SectionMap<Site>) -> HTML {
        HTML(
            .customHead(),
            .body(
                .customHeader(sections: sections, currentSectionID: .projects),
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
            return me(sections: context.sections)
        case .posts:
            return posts(sections: context.sections)
        case .projects:
            return projects(sections: context.sections)
        }
    }
}
