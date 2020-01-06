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

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    let url = URL(string: "https://christianelies.de")!
    let name = "Personal Website"
    let description = "Meet crelies"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? { .init() }
    var tagHTMLConfig: TagHTMLConfiguration? { .default }
}
