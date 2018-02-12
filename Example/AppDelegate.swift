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
public final class AppDelegate: UIResponder {

    public final let window = UIWindow(frame: UIScreen.main.bounds)

}

// MARK: UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {

        /// The ROOT component must specify a size to rendering its content correctly.
        let component = ProfileComponent(
            contentMode: .size(
                width: window.bounds.width,
                height: window.bounds.height
            )
        )

        /// A component should render at least once for showing its view.
        component.render()

        window.render(with: component)

        window.makeKeyAndVisible()

        component
            .fetch(in: .background)
            .then(
                in: .main,
                component.render
            )

        return true

    }

}
