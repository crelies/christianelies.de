//
//  EnsureAllItemsAreTaggedPlugin.swift
//  
//
//  Created by Christian Elies on 06.01.20.
//

import Publish

extension Plugin {
    static var ensureAllItemsAreTagged: Self {
        Plugin(name: "Ensure that all items are tagged") { context in
            let allItems = context.sections.flatMap { $0.items }
            for item in allItems {
                guard !item.tags.isEmpty else {
                    throw PublishingError(
                        path: item.path,
                        infoMessage: "Item has no tags")
                }
            }
        }
    }
}
