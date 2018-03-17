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
    
    public init() {
        
        let storeComponent = UIGridComponent()
        
        self.storeComponent = storeComponent
        
        self.containerViewController = UIComponentViewController(component: storeComponent)
        
        self.productManager = ProductManager()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        storeComponent.render()
        
        productManager
            .fetchProducts(in: .background)
            .then(in: .background) { products -> [UIGridItem] in
                
                return products.map { product in
                    
                    return UIGridItem(
                        title: product.title,
                        subtitle: "$\(product.price)"
                    )
                    
                }
                
            }
            .then(in: .main) { items in
                
                self.storeComponent.setItems(items).render()
                
            }
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
