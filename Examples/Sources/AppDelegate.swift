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
        
        let component = EmojiComponent()
        
        component.view.backgroundColor = .white
        
        component.emoji = Emoji(text: "😎")
        
        window.rootViewController = RootViewController(
            renderable: component
        )
        
        window.makeKeyAndVisible()
        
        component
            .render()
            .always(in: .main) { }
        
        return true

    }

}
