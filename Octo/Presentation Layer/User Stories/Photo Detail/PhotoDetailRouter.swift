//
//  PhotoDetailRouter.swift
//  Octo
//
//  Created by Vladislav Markov on 22.04.2024.
//

import UIKit

protocol PhotoDetailRouting {}

final class PhotoDetailRouter: PhotoDetailRouting {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
