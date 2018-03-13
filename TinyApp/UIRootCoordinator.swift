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
        
        let rootComponent = UIListComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        
        rootComponent.itemComponents = AnyCollection(
            [
                UIProductGalleryComponent(
                    contentMode: .size(
                        width: contentSize.width,
                        height: contentSize.width / (16.0 / 9.0)
                    )
                ),
                UIItemComponent(
                    contentMode: .size(
                        width: 20.0,
                        height: 20.0
                    ),
                    itemView: UIView()
                ),
                UIProductTitleComponent()
            ]
        )
        
//        let rootComponent = UIGridComponent(
//            contentMode: .size(
//                width: contentSize.width,
//                height: contentSize.height
//            )
//        )
//
//        rootComponent.setItems(
//            [
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-1") ],
//                    title: "Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
//                    subtitle: "Integer posuere erat a ante venenatis dapibus posuere velit aliquet."
//                ),
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-2") ],
//                    title: "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus.",
//                    subtitle: "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
//                ),
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-3") ],
//                    title: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur. Cras mattis consectetur purus sit amet fermentum. Cras mattis consectetur purus sit amet fermentum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
//                    subtitle: "Cras mattis consectetur purus sit amet fermentum."
//                )
//            ]
//        )
        
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
