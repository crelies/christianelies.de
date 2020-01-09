//
//  PersonalWebsite.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation
import Plot
import Publish

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case me
        case posts
        case projects
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    let url = URL(string: "https://christianelies.de")!
    let name = "Meet crelies"
    let description = "My personal website including my blog posts"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? { nil }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
}

extension PersonalWebsite {
    var stylesheetPaths: [Path] {
        ["/css/bootstrap.min.css",
         "/css/all.min.css",
         "/css/styles.css"]
    }
}
