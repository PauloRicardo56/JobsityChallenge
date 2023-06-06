//
//  SceneDelegate.swift
//  JobsityChallenge
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Home

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController(rootViewController: ViewController())
        window = .init(windowScene: scene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
