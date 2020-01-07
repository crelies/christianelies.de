//
//  CustomFooter.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Plot

extension Node where Context: HTML.BodyContext {
    static func customFooter() -> Self {
        .footer(
            .class("mb-3"),
            .div(
                .class("text-center \(FontSize.small.cssClass) w-50 center-horizontally"),
                .p(
                    .class("\(TextColor.red.cssClass) text-monospace"),
                    #"""
                        LegalNotice(name: "Christian Elies",
                                    city: "Lüneburg")
                    """#,
                    .br(),
                    .br(),
                    "Copyright © Christian Elies 2020.",
                    .br(),
                    .p(
                        .class("\(TextColor.red.cssClass) mb-0"),
                        "Generated using ",
                        .a(
                            .target(.blank),
                            .class("\(TextColor.red.cssClass) text-decoration-underline"),
                            .href("https://github.com/JohnSundell/Publish"),
                            "Publish"
                        ),
                        ". 100% JavaScript-free."
                    )
                )
            )
        )
    }
}
