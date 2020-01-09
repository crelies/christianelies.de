//
//  AddSectionTitlesPublishingStep.swift
//  
//
//  Created by Christian Elies on 09.01.20.
//

import Publish

extension PublishingStep where Site == PersonalWebsite {
    static func addSectionTitles() -> Self {
        .step(named: "Add section titles") { context in
            context.mutateAllSections { section in
                guard section.title.isEmpty else { return }

                switch section.id {
                case .me:
                    section.title = "Me"
                case .posts:
                    section.title = "Posts"
                case .projects:
                    section.title = "Projects"
                }
            }
        }
    }
}
