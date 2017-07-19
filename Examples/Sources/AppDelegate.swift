//
//  AppDelegate.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 19/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property

    var window: UIWindow?

    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController(
            rootViewController: EmojiListTableViewController(style: .plain)
        )

        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = navigationController

        window.makeKeyAndVisible()

        self.window = window

        return true

    }

}
