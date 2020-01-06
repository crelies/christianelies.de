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
                    "Generated using Publish. 100% JavaScript-free."
                )
            )
        )
    }
}
