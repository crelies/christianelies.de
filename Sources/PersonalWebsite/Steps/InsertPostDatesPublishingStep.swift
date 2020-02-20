//
//  InsertPostDatesPublishingStep.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Plot
import Publish

extension PublishingStep where Site == PersonalWebsite {
    static func insertPostDates() -> Self {
        .step(named: "Insert date in posts") { context in
            context.sections[.posts].mutateItems { post in
                let date: Node = .p(.class("post date"), .text(DateFormatters.post.string(from: post.date)))
                post.content.body.html = date.render() + post.content.body.html
            }
        }
    }
}
