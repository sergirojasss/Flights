//
//  SceneDelegate.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let viewController = OutboundServiceLocator.provideViewController()
        let navigation = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigation
        window.makeKeyAndVisible()

        self.window = window
    }
}
