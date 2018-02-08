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

//        let navigationController = UINavigationController(
//            rootViewController: EmojiListViewController()
//        )
//
//        window.rootViewController = navigationController
        
        let listComponent = ListComponent()
        
        let autoSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
        let post1Component = PostComponent(
            title: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
            content: "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas sed diam eget risus varius blandit sit amet non magna. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."
        )
        
        post1Component.preferredContentSize = autoSize
        
        listComponent.addChild(
            post1Component
        )
        
        let post2Component = PostComponent(
            title: "Nullam quis risus eget urna mollis ornare vel eu leo.",
            content: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui."
        )
        
        post2Component.preferredContentSize = autoSize
        
        listComponent.addChild(
            post2Component
        )
        
        let post3Component = PostComponent(
            title: "Aenean lacinia bibendum nulla sed consectetur.",
            content: "Donec sed odio dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Nulla vitae elit libero, a pharetra augue. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
        )
        
        post3Component.preferredContentSize = autoSize
        
        listComponent.addChild(
            post3Component
        )

        window.rootViewController = RootViewController(
            renderable: listComponent
        )

        window.makeKeyAndVisible()
        
        listComponent.render().then { }
        
        return true

    }

}
