//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyKit
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
        
        let viewController = FeedViewController<MemoryCache<Int, Feed>>()
        
        viewController.layout = TableViewLayout()
        
        let storage: MemoryCache<Int, Feed> = [
            0: .post(Post(id: 0, title: "A", body: "AAA"))
        ]
        
        let prefetchingStorage: MemoryCache<Int, Feed> = [
            0: .comment(Comment(username: "Loading...", text: "Please wait a moment."))
        ]
        
        viewController.storage = storage
        
        viewController._prefetchingStorage = prefetchingStorage
        
//        viewController.storage = FeedStorage(
//            resource: PostResource(client: URLSession.shared)
//        )
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
}
