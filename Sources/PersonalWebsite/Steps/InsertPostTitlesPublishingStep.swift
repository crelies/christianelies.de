//
//  InsertPostTitlesPublishingStep.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Plot
import Publish

extension PublishingStep where Site == PersonalWebsite {
    static func insertPostTitles() -> Self {
        .step(named: "Insert titles in posts") { context in
            context.sections[.posts].mutateItems { post in
                let title: Node = .h1(.text(post.title))
                post.content.body.html = title.render() + post.content.body.html
            }
        }
    }
}
