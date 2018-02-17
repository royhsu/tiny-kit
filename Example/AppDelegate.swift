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

import TinyKit

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {

        /// The ROOT component must specify a size to rendering its content correctly.
//        let component = ProfileComponent(
//            contentMode: .size(
//                width: window.bounds.width,
//                height: window.bounds.height
//            )
//        )
        
        let component = ProfileHeaderComponent(
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
        
        UserManager()
            .fetchUser(
                in: .background,
                id: "1"
            )
            .then(in: .main) { user -> Void in
                
                component.nameLabel.text = user.name
                
                component.introductionLabel.text = user.introduction
                
            }
            .then(
                in: .main,
                component.render /// A component should render at least once for showing its view.
            )
        
        return true

    }

}
