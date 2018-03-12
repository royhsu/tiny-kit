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
    
    private final let rootComponent: Component
    
    public init(contentSize: CGSize) {
        
        let rootComponent = UIGridComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        
        rootComponent.setItems(
            [
                UIGridItem(
                    previewImages: [ #imageLiteral(resourceName: "image-dessert-1") ],
                    title: "Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
                    subtitle: "Integer posuere erat a ante venenatis dapibus posuere velit aliquet."
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                ),
                UIGridItem(
                    previewImages: [],
                    title: "Hello",
                    subtitle: "World"
                )
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
