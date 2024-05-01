//
//  PhotoListModule.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation
import UIKit

enum PhotoListModule {
    enum Section {
        case main
    }
    
    struct Item: Hashable {
        let uniqueId: UUID
        let id: Int
        let title: String
        let previewImageUrl: URL
        let imageUrl: URL
        let author: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uniqueId)
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(previewImageUrl)
            hasher.combine(imageUrl)
            hasher.combine(author)
        }

        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.uniqueId == rhs.uniqueId
                && lhs.id == rhs.id
                && lhs.title == rhs.title
                && lhs.previewImageUrl == rhs.previewImageUrl
                && lhs.imageUrl == rhs.imageUrl
                && lhs.author == rhs.author
        }
    }
    
    enum Error: LocalizedError {
        case invalidAuthorization
        case unknown(Swift.Error?)

        var errorDescription: String? {
            switch self {
            case .invalidAuthorization:
                return AppLocalization.Error.invalidAuthorization.localized
            case let .unknown(error):
                return error?.localizedDescription ?? AppLocalization.Error.unknown.localized
            }
        }
    }
}
