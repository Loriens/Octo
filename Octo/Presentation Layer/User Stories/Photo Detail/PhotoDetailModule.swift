//
//  PhotoDetailModule.swift
//  Octo
//
//  Created by Vladislav Markov on 22.04.2024.
//

import Foundation

enum PhotoDetailModule {
    struct Item: Hashable {
        let id: Int
        let title: String
        let imageUrl: URL
        let author: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(imageUrl)
            hasher.combine(author)
        }

        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
                && lhs.title == rhs.title
                && lhs.imageUrl == rhs.imageUrl
                && lhs.author == rhs.author
        }
    }
}
