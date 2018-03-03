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
    
    private final let rootComponent: UICollectionComponent
    
    public init(contentSize: CGSize) {
        
        let flowLayout = UICollectionViewFlowLayout()
        
//        flowLayout.sectionInset = .zero
//        
//        flowLayout.minimumInteritemSpacing = 0.0
//
//        flowLayout.minimumLineSpacing = 0.0
    
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        flowLayout.scrollDirection = .horizontal
        
        let rootComponent = UICollectionComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            ),
            collectionLayout: flowLayout
        )
        
        let postComponent = UIPostComponent(
            contentMode: .size(width: 150.0, height: 150.0)
        )
        
        postComponent.setPost(
            UIPost(
                title: "aaaaaa",
                content: "😎"
            )
        )
        
        let post2Component = UIPostComponent(
            contentMode: .size(width: 150.0, height: 150.0)
        )
            
        post2Component.setPost(
            UIPost(
                title: "aaaaaa",
                content: "😎"
            )
        )
        
        rootComponent.itemComponents = AnyCollection(
            [
                postComponent,
                post2Component
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
