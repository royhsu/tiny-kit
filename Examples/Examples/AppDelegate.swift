//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyStorage
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
        
        let viewController = FeedViewController<TinyStorage.MemoryCache<Int, Feed>>()
        
        viewController.layout = TableViewLayout()
        
        let storage: TinyStorage.MemoryCache<Int, Feed> = [
            0: .post(Post(id: 0, title: "Loading...", body: ""))
        ]
        
        viewController.storage = storage
        
//        let prefetchingStorage = RemoteStorage(resource: DummyResource())
//
//        let loadings: [(Int, Feed?)] = [
//            (0, .post(Post(id: 0, title: "Loading...", body: "")))
//        ]
//
//        prefetchingStorage.merge(
//            AnySequence(loadings),
//            options: .muteBroadcaster
//        )
        
//        viewController._prefetchingStorage = prefetchingStorage
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
}

import TinyCore

public struct DummyResource: Resource {
    
    public func fetchItems(
        page: Page,
        completionHandler: @escaping (Result< FetchItemsPayload<Feed> >) -> Void
    ) {
        
        let last = Int.random(in: 1...20)
        
        let posts = (0..<last).map { Post(id: $0, title: "\($0)", body: "") }
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
            
            completionHandler(
                .success(
                    FetchItemsPayload(
                        items: posts.map { $0.feed }
                    )
                )
            )
            
        }
        
    }
    
}
