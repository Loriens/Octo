//
//  PhotoDetailFactory.swift
//  Octo
//
//  Created by Vladislav Markov on 22.04.2024.
//

import UIKit

final class PhotoDetailFactory {
    private let item: PhotoDetailModule.Item
    
    init(item: PhotoDetailModule.Item) {
        self.item = item
    }

    func create() -> UIViewController {
        let viewModel = PhotoDetailViewModel(item: item)
        let viewController = PhotoDetailView(viewModel: viewModel)
        viewController.router = PhotoDetailRouter(viewController: viewController)
        return viewController
    }
}

