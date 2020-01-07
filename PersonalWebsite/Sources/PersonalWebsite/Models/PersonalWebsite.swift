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

    let url = URL(string: "https://crelies.github.io/christianelies.de")!
    let name = "Personal Website"
    let description = "Meet crelies"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? { nil }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
}
