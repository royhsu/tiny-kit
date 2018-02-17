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

import Hydra
import TinyKit

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

        let rootViewController = ComponentViewController(
            component: component
        )

        rootViewController.view.backgroundColor = .red

        window.rootViewController = rootViewController

        window.makeKeyAndVisible()

        let userId = "1"

        let fetchUser: Promise<Void> = UserManager()
            .fetchUser(
                in: .background,
                userId: userId
            )
            .then(in: .main) { user -> Void in

                component.name = user.name

                component.introduction = user.introduction

            }

        let fetchPosts: Promise<Void> = PostManager()
            .fetchPosts(
                in: .background,
                userId: userId
            )
            .then(
                in: .main,
                component.appendPosts
            )

        all(
            fetchUser,
            fetchPosts
        )
        .always(
            in: .main,
            body: component.render
        )

        return true

    }

}
