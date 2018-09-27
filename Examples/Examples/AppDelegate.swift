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
//        
//        let viewController = FeedViewController<FeedRemoteStorage>()
//
//        viewController.layout = TableViewLayout()

//        viewController.storage = FeedRemoteStorage(
//            resource: PostResource(client: URLSession.shared)
//        )
//
//        viewController.storage = FeedRemoteStorage(
//            resource: DummyResource()
//        )

//        viewController._prefetchingSessions = PrefetchingFeedSectionColleciton(
//            sections: [
//                PrefetchingFeedSectionColleciton.Section(
//                    elements: [ .indicator ]
//                )
//            ]
//        )

        window.rootViewController = UINavigationController(
            rootViewController: NumberListViewController()
        )

        window.makeKeyAndVisible()

        return true

    }

}

//import TinyCore
//import TinyStorage
//
//public struct DummyResource: Resource {
//
//    public func fetchItems(
//        page: Page,
//        completion: @escaping (Result< FetchItemsPayload<Feed> >) -> Void
//    ) {
//
//        let last = Int.random(in: 1...20)
//
////        let items = (0..<last).map {
//        let items = (0..<1).map {
//
//            Post(id: $0, title: "\($0)", body: "")
//
////            Comment(id: $0, username: "\($0)", text: "Hello")
//
//        }
//
//        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
//
//            completion(
//                .success(
//                    FetchItemsPayload(
//                        items: items.map { $0.feed }
//                    )
//                )
//            )
//
//        }
//
//    }
//
//}
