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

//        let component = PostComponent()
//
//        component.view.backgroundColor = .white
//
//        component.post = Post(
//            title: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
//            content: "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur blandit tempus porttitor. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla."
//        )
        
        let component = ProfileHeaderComponent()
        
//        let component = PostListComponent()
        
        component.view.backgroundColor = .white

        window.rootViewController = RootViewController(
            renderable: component
        )

        window.makeKeyAndVisible()  

        component
            .fetch(in: .background)
            .then(in: .main, component.render)
            .always(in: .main) {
                
                self.window.rootViewController?.view.frame = UIScreen.main.bounds

            }

        return true

    }

}
