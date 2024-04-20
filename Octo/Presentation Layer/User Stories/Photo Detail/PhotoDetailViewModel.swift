//
//  PhotoDetailViewModel.swift
//  Octo
//
//  Created by Vladislav Markov on 22.04.2024.
//

import Combine
import Foundation

final class PhotoDetailViewModel {
    @Published var title: String?
    @Published var imageUrl: URL?

    private let item: PhotoDetailModule.Item
    
    init(item: PhotoDetailModule.Item) {
        self.item = item
    }
    
    func loadData() {
        title = item.title
        imageUrl = item.imageUrl
    }
}
