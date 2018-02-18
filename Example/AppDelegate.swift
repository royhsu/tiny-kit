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

// MARK: - UIApplicationDelegate

import Hydra
import TinyKit

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {

        /// The ROOT component must specify a size to render its content correctly.
        let component = UIProfileComponent(
            contentMode: .size(
                width: window.bounds.width,
                height: window.bounds.height
            )
        )

        window.rootViewController = UINavigationController(
            rootViewController: ComponentViewController(component: component)
        )

        window.makeKeyAndVisible()

        let userId = "1"

        let fetchUser: Promise<Void> = UserManager()
            .fetchUser(
                in: .background,
                userId: userId
            )
            .then { user -> UIProfileIntroduction in

                return UIProfileIntroduction(
                    name: user.name,
                    introduction: user.introduction
                )

            }
            .then(
                in: .main,
                component.setIntroduction
            )

        let fetchPosts: Promise<Void> = PostManager()
            .fetchPosts(
                in: .background,
                userId: userId
            )
            .then { posts -> [UIPost] in

                return posts.map { post in

                    return UIPost(
                        title: post.title,
                        content: post.content
                    )

                }

            }
            .then(
                in: .main,
                component.setPosts
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
