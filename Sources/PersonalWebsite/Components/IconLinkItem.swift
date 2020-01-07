//
//  IconLinkItem.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot

extension Node where Context == HTML.ListContext {
    static func iconLinkItem(url: URL, icon: Icon, fontSize: FontSize = .medium) -> Self {
        .li(
            .class("list-inline-item"),
            .a(
                .class(TextColor.red.cssClass),
                .target(.blank),
                .href(url),
                .i(.class("\(icon.cssClass) \(fontSize.cssClass)")))
        )
    }
}
