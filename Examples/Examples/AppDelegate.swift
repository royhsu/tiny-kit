//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let viewController = PostViewController()
        
        viewController.storage = PostStorage()
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        
        window.makeKeyAndVisible()
        
        viewController.storage?.setValues(
            [
                .post(
                    Post(
                        id: 1,
                        title: "Awesome Template",
                        body: "This is an example."
                    )
                ),
                .comment(
                    Comment(
                        username: "Roy",
                        text: "Hi"
                    )
                )
            ]
        )
        
        return true
            
    }
    
}
