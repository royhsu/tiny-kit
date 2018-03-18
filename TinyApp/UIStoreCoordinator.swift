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
    
    private final var products: [Product]
    
    public init() {
        
        let storeComponent = UIGridComponent()
        
        self.containerViewController = UIComponentViewController(component: storeComponent)
    
        self.storeComponent = storeComponent
        
        self.productManager = ProductManager()
        
        self.products = []
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        storeComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in 3 }
            .setComponentForItem { indexPath in
                
                return UIGridItemComponent(
                    contentMode: .size(
                        width: 0.0,
                        height: 0.0
                    )
                )
                .setTitle("Hello")
                .setSubtitle("World")
                .setPreviewImages(
                    [ #imageLiteral(resourceName: "image-dessert-1") ]
                )
                
            }
            .render()
        
//        productManager
//            .fetchProducts(in: .background)
//            .then(in: .background) { products -> [UIGridItem] in
//                
//                self.products = products
//                
//                return products.map { product in
//                    
//                    return UIGridItem(
//                        title: product.title,
//                        subtitle: "$\(product.price)"
//                    )
//                    
//                }
//                
//            }
//            .then(in: .main) { items in
//                
//                self.storeComponent.setItems(items).render()
//                
//            }
//            .catch(in: .main) { error in
//                
//                // TODO: error handling.
//                print("\(error)")
//                
//            }
        
    }
    
}

// MARK:  - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return containerViewController }
    
}
