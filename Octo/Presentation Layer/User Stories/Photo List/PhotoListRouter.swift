//
//  PhotoListRouter.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

protocol PhotoListRouting {
    func routeToPhotoDetail(item: PhotoDetailModule.Item)
    func presentAlert(error: Error)
}

final class PhotoListRouter: PhotoListRouting {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToPhotoDetail(item: PhotoDetailModule.Item) {
        let factory = PhotoDetailFactory(item: item)
        let vc = factory.create()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func presentAlert(error: Error) {
        let title = AppLocalization.General.error.localized
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: AppLocalization.General.ok.localized, style: .default)
        alertController.addAction(action)

        viewController?.present(alertController, animated: true)
    }
}
