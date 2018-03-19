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
    
    // TODO:
    // 1. wishlist cart manager in home
    // 2. checkout cart manager in checkout process
    private final let cartManager: CartManager
    
    public typealias ShowProductDetailHandler = (_ viewController: UIViewController) -> Void
    
    private final var showProductDetailHandler: ShowProductDetailHandler?
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
        self.cartContentComponent = UINewListComponent()
        
        self.storeCoordinator = UIStoreCoordinator()
        
        self.cartManager = CartManager()
        
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
            .setNumberOfItems { [unowned self] _ in self.cartManager.cart.value.count }
            .setComponentForItem { [unowned self] indexPath in
                
                let cart = self.cartManager.cart
                
                let itemDescriptor = cart.value[indexPath.row]
                
                var item = UICartItem(
                    previewImage: nil,
                    title: itemDescriptor.item.title,
                    price: itemDescriptor.item.price
                )
                
                let component = UICartItemComponent()
                    
                component
                    .setQuantity(itemDescriptor.quantity)
                    .setDidChangeSelection { isSelected in
                        
                        cart.value[indexPath.row].isSelected = isSelected
                        
                        print(
                            "onToggleSelection",
                            cart.value[indexPath.row].isSelected
                        )
                        
                    }
                    .setDidChagneQuantity { quantiy in
                     
                        cart.value[indexPath.row].quantity = quantiy
                        
                        print(
                            "setDidChagneQuantity",
                            cart.value[indexPath.row].quantity
                        )
                        
                    }
                
                // TODO: emulate image downloading process.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                    item.previewImage = #imageLiteral(resourceName: "image-dessert-1")

                }
                
                return component
                
            }
            .render()
        
        cartCoordinator.activate()
        
        storeCoordinator
            .setDidSelectProduct { [unowned self] product in
                
                let itemDescriptor = CartItemDescriptor(
                    item: product,
                    quantity: 10,
                    isSelected: true
                )

                self.cartManager.cart.value.append(itemDescriptor)

                self.cartContentComponent.render()
                
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
//                self.showProductDetailHandler?(containerViewControlller)
                
            }
            .activate()
        
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
    
    @discardableResult
    public final func setShowProductDetail(_ handler: ShowProductDetailHandler?) -> UIHomeCoordinator {
        
        showProductDetailHandler = handler
        
        return self
        
    }

}

// MARK: - ViewControllerRepresentable

extension UIHomeCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
