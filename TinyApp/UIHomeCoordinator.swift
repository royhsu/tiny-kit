//
//  UIHomeCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeCoordinator

import TinyKit
import TinyStore

public final class UIHomeCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    private final let cartCoordinator: UICartCoordinator
    
    private final let cartContentComponent: UINewListComponent
    
    private final let storeCoordinator: UIStoreCoordinator
    
    public typealias CartItemDescriptorForItemHandler = (IndexPath) -> CartItemDescriptor
    
    private final var cartItemDescriptorForItemHandler: CartItemDescriptorForItemHandler?
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
        self.cartContentComponent = UINewListComponent()
        
        self.storeCoordinator = UIStoreCoordinator()
        
        collapseBarController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(toggleCartContent)
        )
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        collapseBarController.setBarContentViewController(
            UIComponentViewController(component: cartContentComponent)
        )
        
        collapseBarController.setBarViewController(cartCoordinator.viewController)
        
        collapseBarController.setBackgroundViewController(storeCoordinator.viewController)
        
        cartContentComponent
            .setNumberOfSections { 1 }
            .setComponentForItem { /* [unowned self] */ indexPath in
                
                guard
                    let itemDescriptor = self.cartItemDescriptorForItemHandler?(indexPath)
                else { return nil }
                
                var item = UICartItem(
                    previewImage: nil,
                    title: itemDescriptor.item.title,
                    price: itemDescriptor.item.price
                )
                
                // TODO: [bug] the component will be released after ended this function.
                let component = UICartItemComponent()
                    .setItem(item)
                
                // TODO: emulate image downloading process.
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//
//                    item.previewImage = #imageLiteral(resourceName: "image-dessert-1")
//
//                    component.setItem(item)
//
//                }
                
                return component
                
            }
            .render()
        
        cartCoordinator.activate()
        
        storeCoordinator.activate()
        
    }
    
    // TODO: temporarily solution.
    public final func render() {
        
//        cartCoordinator.activate()
        
        cartContentComponent.render()
        
    }
    
    @objc
    public final func toggleCartContent(_ sender: Any) {
        
        collapseBarController.setCollapsed(
            !collapseBarController.isCollapsed,
            animated: true
        )
        
    }
    
}

public extension UIHomeCoordinator {
    
    public typealias DidSelectProductHandler = UIStoreCoordinator.DidSelectProductHandler
    
    @discardableResult
    public final func setDidSelectProduct(_ handler: DidSelectProductHandler?) -> UIHomeCoordinator {
        
        storeCoordinator.setDidSelectProduct(handler)
        
        return self
        
    }
    
    public typealias NumberOfCartItemDescriptorsHandler = () -> Int
    
    @discardableResult
    public final func setNumberOfCartItemDescriptors(_ handler: NumberOfCartItemDescriptorsHandler?) -> UIHomeCoordinator {
        
        if let handler = handler {
         
            cartContentComponent.setNumberOfItems { _ in handler() }
            
        }
        else { cartContentComponent.setNumberOfItems(nil) }
        
        return self
        
    }
    
    @discardableResult
    public final func setCartItemDescriptorForItem(_ handler: CartItemDescriptorForItemHandler?) -> UIHomeCoordinator {
        
        cartItemDescriptorForItemHandler = handler
        
        return self
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
