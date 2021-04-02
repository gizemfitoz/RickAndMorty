//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 2.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        app.router.start()
        return true
    }
}

