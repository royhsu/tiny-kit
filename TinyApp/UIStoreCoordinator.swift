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
    
    private final let productManager: ProductManager
    
    private final var products: [Product] {
        
        didSet {
            
            storeComponent
                .setNumberOfSections { 1 }
                .setNumberOfItems { _ in self.products.count }
                .setComponentForItem { indexPath in
                    
                    let product = self.products[indexPath.row]
                    
                    // Prevent the size of an item greater than the collection view, that will raise an exception.
                    return UIGridItemComponent(
                        contentMode: .size(
                            width: 0.0,
                            height: 0.0
                        )
                    )
                    .setTitle(product.title)
                    .setSubtitle("$\(product.price)")
                    .setPreviewImages(
                        [ #imageLiteral(resourceName: "image-dessert-1") ]
                    )
                    
                }
                .render()
            
        }
        
    }
    
    public init() {
        
        let storeComponent = UIGridComponent()
        
        self.containerViewController = UIComponentViewController(component: storeComponent)
    
        self.storeComponent = storeComponent
        
        self.productManager = ProductManager()
        
        self.products = []
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        storeComponent.render()
        
        productManager
            .fetchProducts(in: .background)
            .then(in: .main) { self.products = $0 }
            .catch(in: .main) { error in
                
                // TODO: error handling.
                print("\(error)")
                
            }
        
    }
    
}

// MARK:  - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return containerViewController }
    
}
