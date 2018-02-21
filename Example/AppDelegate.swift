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

import TinyKit

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {

        /// The ROOT must specify a size to render its content correctly.
//        let rootCoordinator = UIProfileCoordinator(
//            contentSize: window.bounds.size,
//            userId: "1",
//            userManager: UserManager(),
//            postManager: PostManager()
//        )
//
//        window.rootViewController = UIViewRendererController(renderable: rootCoordinator)
        
        //        rootCoordinator.activate()

        let rootComponent = UISignInComponent(
            contentMode: .size(
                width: window.bounds.width,
                height: window.bounds.height
            )
        )
        
        rootComponent.render()
        
        window.rootViewController = UIViewRendererController(renderable: rootComponent)
        
        window.makeKeyAndVisible()

        return true

    }

}
