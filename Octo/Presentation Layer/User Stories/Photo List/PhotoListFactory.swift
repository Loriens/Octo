//
//  PhotoListFactory.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

final class PhotoListFactory {
    init() {}

    func create() -> UIViewController {
        let networkService = DefaultNetworkService()
        let viewModel = PhotoListViewModel(networkService: networkService)
        let viewController = PhotoListView(viewModel: viewModel)
        viewController.router = PhotoListRouter(viewController: viewController)
        return viewController
    }
}
