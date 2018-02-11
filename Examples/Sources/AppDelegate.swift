//
//  AppDelegate.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 19/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit
import TinyKit

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
        
        let size = UIScreen.main.bounds.size
        
        let component = ProfileComponent(
            contentMode: .size(
                width: size.width,
                height: size.height
            )
        )
        
        component.render()

        window.rootViewController = RootViewController(renderable: component)

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
