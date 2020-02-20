//
//  IconLinkItem.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot

extension Node where Context == HTML.ListContext {
    static func iconLinkItem(url: URL, icon: Icon) -> Self {
        .li(
            .class("list-inline-item"),
            .a(
                .target(.blank),
                .href(url),
                .i(.class("\(icon.cssClass)")))
        )
    }
}
