//
//  SocialLinks.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Foundation
import Plot

extension Node where Context: HTML.BodyContext {
    static func socialLinks() -> Self {
        .ul(
            .class("list-inline text-center pb-4 mb-0 social-links"),
            .iconLinkItem(url: URL(string: "https://github.com/crelies")!, icon: .github),
            .iconLinkItem(url: URL(string: "https://medium.com/@crelies")!, icon: .medium),
            .iconLinkItem(url: URL(string: "https://stackoverflow.com/story/crelies")!, icon: .stackoverflow),
            .iconLinkItem(url: URL(string: "https://www.xing.com/profile/Christian_Elies2")!, icon: .xing),
            .iconLinkItem(url: URL(string: "https://www.linkedin.com/in/christian-elies-b1009b104")!, icon: .linkedin)
        )
    }
}
