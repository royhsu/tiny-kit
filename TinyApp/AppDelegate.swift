//
//  AppDelegate.swift
//  TinyApp
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {

    public final let appCoordinator = UIApplicationCoordinator(contentSize: UIScreen.main.bounds.size)

}

// MARK: - UIApplicationDelegate

import TinyKit

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {

        appCoordinator.activate()

        return true

    }

}
