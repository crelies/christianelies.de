//
//  PersonalWebsiteTheme.swift
//  
//
//  Created by Christian Elies on 04.01.20.
//

import Foundation
import Plot
import Publish

extension Theme where Site == PersonalWebsite {
    static var personal: Self { Theme(htmlFactory: PersonalHTMLFactory()) }

    private struct PersonalHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .customHead(),
                .body(
                    .customHeader(sections: context.sections, currentSectionID: nil),
                    .div(
                        .class("page-wrapper container \(TextColor.white.cssClass)"),
                        .div(
                            .h2(
                                .class("mb-3"),
                                "Latest post"
                            ),
                            .postCard(item: context.allItems(sortedBy: \.date, order: .descending).first!)
                        )
                    ),
                    .customFooter()
                )
            )
        }

        func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
            section.html(context: context)
        }

        func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .customHead(),
                .body(
                    .customHeader(sections: context.sections, currentSectionID: .posts),
                    .div(
                        .class("page-wrapper \(TextColor.white.cssClass)"),
                        .contentBody(item.body)
                    ),
                    .customFooter()
                )
            )
        }

        func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
            HTML()
        }

        func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .customHead(),
                .body(
                    .customHeader(sections: context.sections, currentSectionID: nil),
                    .div(
                        .class("page-wrapper \(TextColor.white.cssClass)"),
                        .h2("Browse by tag", .class("mb-3")),
                        .forEach(page.tags.sorted(by: <)) { tag in
                            .linkTag(tag, fontSize: .large, color: tag.color)
                        }
                    ),
                    .customFooter()
                )
            )
        }

        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .customHead(),
                .body(
                    .customHeader(sections: context.sections, currentSectionID: nil),
                    .div(
                        .class("page-wrapper \(TextColor.white.cssClass)"),

                        .div(
                            .class("row justify-content-between"),
                            .div(
                                .class("col-8"),
                                .h2(
                                    .div(
                                        .class("align-horizontally mb-3"),
                                        "Tagged with",
                                        .tag(page.tag.string, fontSize: .large, color: page.tag.color, additionalCssClasses: ["ml-2", "pt-2", "pb-2"])
                                    )
                                )
                            ),
                            .div(
                                .class("col"),
                                .p(
                                    .class("text-right align-middle"),
                                    .a(
                                        .class(TextColor.red.cssClass),
                                        .href("/tags"),
                                        "Browse all tags"
                                    )
                                )
                            )
                        ),

                        .forEach(context.items(taggedWith: page.tag)) { item in
                            .postCard(item: item)
                        }
                    ),
                    .customFooter()
                )
            )
        }
    }
}
