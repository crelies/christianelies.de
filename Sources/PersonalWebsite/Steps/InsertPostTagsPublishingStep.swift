//
//  InsertPostTagsPublishingStep.swift
//
//
//  Created by Christian Elies on 06.01.20.
//

import Plot
import Publish

extension PublishingStep where Site == PersonalWebsite {
    static func insertPostTags() -> Self {
        .step(named: "Insert tags in posts") { context in
            let site = context.site
            context.sections[.posts].mutateItems { post in
                let tags: Node = .forEach(post.tags) { tag -> Node<HTML.BodyContext> in
                    .linkTag(site: site, tag, fontSize: .small, color: tag.color)
                }
                post.content.body.html = tags.render() + post.content.body.html
            }
        }
    }
}
