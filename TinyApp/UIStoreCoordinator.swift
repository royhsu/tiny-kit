//
//  UIStoreCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

/// MARK: - UIStoreCoordinator

import TinyKit
import TinyStore

public final class UIStoreCoordinator: Coordinator {
    
    /// The navigator.
    private final let containerViewController: UIComponentViewController
    
    private final let storeComponent: UIGridComponent
    
    public init() {
        
        let storeComponent = UIGridComponent()
        
        self.storeComponent = storeComponent
        
        self.containerViewController = UIComponentViewController(component: storeComponent)
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {

        storeComponent.setItems(
            [
                UIGridItem(
                    previewImages: [ #imageLiteral(resourceName: "image-dessert-1") ],
                    title: "Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
                    subtitle: "Integer posuere erat a ante venenatis dapibus posuere velit aliquet."
                ),
                UIGridItem(
                    previewImages: [ #imageLiteral(resourceName: "image-dessert-2") ],
                    title: "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus.",
                    subtitle: "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
                ),
                UIGridItem(
                    previewImages: [ #imageLiteral(resourceName: "image-dessert-3") ],
                    title: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur. Cras mattis consectetur purus sit amet fermentum. Cras mattis consectetur purus sit amet fermentum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
                    subtitle: "Cras mattis consectetur purus sit amet fermentum."
                )
            ]
        )
        
        storeComponent.render()
        
    }
    
}

// MARK:  - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return containerViewController }
    
}
