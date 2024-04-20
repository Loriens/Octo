//
//  SceneDelegate.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let rootViewController = PhotoListFactory().create()
        let navigationController = BasicNavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

