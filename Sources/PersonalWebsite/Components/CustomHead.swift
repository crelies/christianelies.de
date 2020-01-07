//
//  CustomHead.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot
import Publish

extension Node where Context == HTML.DocumentContext {
    static func customHead(site: PersonalWebsite) -> Self {
        .head(
            .title("Personal Website"),
            .stylesheet(URL(string: "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css")!),
            .stylesheet(URL(string: "https://use.fontawesome.com/releases/v5.6.3/css/all.css")!),
            .stylesheet(site.url(for: Path("styles.css"))),
            .encoding(.utf8),
            .viewport(.accordingToDevice, initialScale: 1)
        )
    }
}
