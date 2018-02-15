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
    
    public final let navigation: Navigation = Navigator()

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
        let component = ProfileComponent(
            contentMode: .size(
                width: window.bounds.width,
                height: window.bounds.height
            )
        )

        /// A component should render at least once for showing its view.
        component.render()

//        window.render(with: component)

//        navigation.register(
//            URL(string: "tinykit://yellow")!,
//            with: { url, info in
//
//                return YellowViewController()
//
//            }
//        )
//
        let postComponent = PostComponent(
            post: Post(
                title: "Sed posuere consectetur est at lobortis. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit.",
                content: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
            )
        )
        
        let postListComponent = ListComponent()

        postListComponent.itemComponents = AnyCollection(
            [
               postComponent
            ]
        )
        
//        let postListComponent = PostListComponent()
//
//        postListComponent.view.backgroundColor = .white
        
//        let navigationComponent = TinyNavigationComponent(
//            contentMode: .size(
//                width: window.bounds.width,
//                height: window.bounds.height
//            ),
//            rootComponent: postListComponent
//        )

//        let rootViewController = UIViewController()
//
//        rootViewController.view.backgroundColor = .red
        
        window.rootViewController = RootViewController(
            renderable: component
        )
        
        window.makeKeyAndVisible()
        
//        postListComponent.render()
        
//        print("2", postListComponent.view)
        
//        postComponent.render()

//        postListComponent.render()
//
//        rootViewController.view.render(with: postListComponent)

        
        
        
        
//        print("3", postListComponent.view)
        
        component
            .fetch(in: .background)
            .then(
                in: .main,
                component.render
            )
//            .then(
//                in: .main,
//                navigationComponent.render
//            )
//            .then(
//                in: .main,
//                postListComponent.render
//            )

        return true

    }

}
