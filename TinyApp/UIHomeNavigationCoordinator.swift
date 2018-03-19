//
//  UIHomeNavigationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeNavigationCoordinator

import TinyKit
import TinyStore

public final class UIHomeNavigationCoordinator: Coordinator {
    
    /// The navigator.
    private final let navigationController: UINavigationController
    
    private final let homeCoordinator: UIHomeCoordinator
    
    private final let cartManager: CartManager
    
    private final var cartSubscription: Subscription<[CartItemDescriptor]>?
    
    public init() {
        
        let homeCoordinator = UIHomeCoordinator()
        
        self.homeCoordinator = homeCoordinator
        
        self.navigationController = UINavigationController(rootViewController: homeCoordinator.viewController)
        
        self.cartManager = CartManager()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        cartSubscription = cartManager.cart.subscribe { /* [unowned self] */ _, newDescriptors in
                
            self.homeCoordinator
                .setNumberOfCartItemDescriptors { newDescriptors.count }
                .setCartItemDescriptorForItem { indexPath in newDescriptors[indexPath.item] }
                .render()
            
        }
        
        homeCoordinator
            .setDidSelectProduct { product in
                
                let itemDescriptor = CartItemDescriptor(
                    item: product,
                    quantity: 10,
                    isSelected: true
                )
                
                self.cartManager.cart.value.append(itemDescriptor)
                
//                let detailComponent = UIProductDetailComponent()
//
//                let containerViewControlller = UIComponentViewController(component: detailComponent)
//
//                detailComponent
//                    .setDescription(
//                        UIProductDescription(
//                            title: product.title,
//                            subtitle: "$\(product.price)"
//                        )
//                    )
//                    .setAction {
//
//                        let cartItemDescriptor = CartItemDescriptor(
//                            item: product,
//                            quantity: 10,
//                            isSelected: true
//                        )
//
//                        // TODO: prevent adding a duplicate item.
//                        self.cartManager.cart.value.append(cartItemDescriptor)
//
//                    }
//                    .render()
//
//                self.navigationController.pushViewController(
//                    containerViewControlller,
//                    animated: true
//                )
                
            }
            .activate()
    
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeNavigationCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
