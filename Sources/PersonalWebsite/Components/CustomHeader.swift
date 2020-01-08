//
//  CustomHeader.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot
import Publish

extension Node where Context: HTML.BodyContext {
    static func customHeader(context: PublishingContext<PersonalWebsite>, currentSectionID: PersonalWebsite.SectionID?) -> Self {
        .header(
            .div(
                .class("text-center pt-4 \(FontSize.small.cssClass)"),
                .a(
                    .class("\(TextColor.red.cssClass) text-monospace"),
                    .href("/"),
                    .p(.class("mb-0"), "debugPrint(\"Hello world!\")"))
            ),
            .navigationBar(context: context, currentSectionID: currentSectionID),
            .socialLinks()
        )
    }
}
