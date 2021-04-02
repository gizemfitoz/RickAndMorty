//
//  AppRouter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 2.04.2021.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
