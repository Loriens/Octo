//
//  BasicNavigationController.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

final class BasicNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    private func setupComponents() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppStyle.Background.basic
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        navigationBar.isTranslucent = false
        navigationBar.tintColor = AppStyle.Text.primary
        navigationBar.titleTextAttributes = [
            .font: PTRootUI.bold.dynamicallyScalingFont(size: 20) as Any,
            .foregroundColor: AppStyle.Text.primary as Any
        ]
        navigationBar.prefersLargeTitles = false
    }
}
