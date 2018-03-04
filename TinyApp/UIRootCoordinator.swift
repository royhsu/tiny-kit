//
//  UIRootCoordinator.swift
//  TinyKitApp
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyStore
import TinyKit

public final class UIRootCoordinator: Coordinator {
    
    private final let navigationController: UINavigationController
    
    private final let rootComponent: UIProductComponent
    
    public init(contentSize: CGSize) {
        
        let rootComponent = UIProductComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        .setImages(
            [
                #imageLiteral(resourceName: "image-dessert-1"),
                #imageLiteral(resourceName: "image-dessert-2"),
                #imageLiteral(resourceName: "image-dessert-3")
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
