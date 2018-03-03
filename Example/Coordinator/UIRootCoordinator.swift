//
//  UIRootCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

public final class UIRootCoordinator: Coordinator {
    
    private final let navigationController: UINavigationController
    
    private final let rootComponent: UICarouselComponent
    
    public init(contentSize: CGSize) {
        
        let rootComponent = UICarouselComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        
        let post1Component = UIPostComponent(
//            contentMode: .size(
//                width: 736,
//                height: 736
//            )
        )
        
        post1Component.setPost(
            UIPost(
                title: "1",
                content: "😎"
            )
        )
        
        let post2Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
            
        post2Component.setPost(
            UIPost(
                title: "2",
                content: "😎"
            )
        )
        
        let post3Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post3Component.setPost(
            UIPost(
                title: "3",
                content: "😎"
            )
        )
        
        let post4Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post4Component.setPost(
            UIPost(
                title: "4",
                content: "😎"
            )
        )
        
        let post5Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post5Component.setPost(
            UIPost(
                title: "5",
                content: "😎"
            )
        )
        
        let post6Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post6Component.setPost(
            UIPost(
                title: "6",
                content: "😎"
            )
        )
        
        let post7Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post7Component.setPost(
            UIPost(
                title: "7",
                content: "😎"
            )
        )
        
        let post8Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post8Component.setPost(
            UIPost(
                title: "8",
                content: "😎"
            )
        )
        
        let post9Component = UIPostComponent(
//            contentMode: .size(
//                width: 100.0,
//                height: 450.0
//            )
        )
        
        post9Component.setPost(
            UIPost(
                title: "9",
                content: "😎"
            )
        )
        rootComponent.itemComponents = AnyCollection(
            [
                post1Component,
                post2Component,
                post3Component,
                post4Component,
                post5Component,
                post6Component,
                post7Component,
                post8Component,
                post9Component
            ]
        )
        
        self.rootComponent = rootComponent
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )
        
    }
    
    public final func activate() { rootComponent.render() }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
