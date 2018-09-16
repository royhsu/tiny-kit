//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyCore
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
        
        typealias PostViewController = TableViewController<PostSectionCollection, PostStorage>

        let viewController = PostViewController()
        
        viewController.reducer = { storage in
            
            return PostSectionCollection(
                sections: storage.pairs.map { pair in
                
                    switch pair.value {
                        
                    case let .post(storage):
                        
                        let template = PostTemplate(
                            storage: storage,
                            elements: [
                                .title,
                                .body
                            ]
                        )
                        
                        template.configuration = PostTemplateConfiguration()
                        
                        template.registerView(
                            LargeTitleLabel.self,
                            binding: { storage, view in
                                
                                let label = view as? LargeTitleLabel
                                
                                label?.text = storage.title
                                
                            },
                            for: .title
                        )
                        
                        template.registerView(
                            TitleLabel.self,
                            binding: { storage, view in
                            
                                let label = view as? TitleLabel
                                
                                label?.text = storage.title
                                
                            },
                            for: .title
                        )
                        
                        template.registerView(
                            BodyLabel.self,
                            binding: { storage, view in
                                
                                let label = view as? BodyLabel
                                
                                label?.text = storage.body
                                
                            },
                            for: .body
                        )
                        
                        return .post(template)
                        
                    case let .comment(storage):
                        
                        let template = CommentTemplate(
                            storage: storage,
                            elements: [
                                .username,
                                .text
                            ]
                        )

                        return .comment(template)
                        
                    }
                    
                }
             )
            
        }
    
        viewController.storage = PostStorage()
        
        window.rootViewController = UINavigationController(
            rootViewController: viewController
        )
        
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
