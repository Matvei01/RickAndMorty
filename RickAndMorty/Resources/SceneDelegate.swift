//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = RMTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}

