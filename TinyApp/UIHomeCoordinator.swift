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
import TinyUI

public final class UIHomeCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    private final let cartCoordinator: UICartCoordinator
    
    private final let cartContentComponent: UINewListComponent
    
    private final var cartItemComponents: [UICartItemComponent]
    
    private final let storeCoordinator: UIStoreCoordinator
    
    // TODO:
    // 1. wishlist cart manager in home
    // 2. checkout cart manager in checkout process
    private final let cartManager: CartManager
    
    public typealias ItemID = String
    
    private final var selectionSubscriptionMap: [ItemID: Subscription<Bool>]
    
    private final var quantitySubscriptionMap: [ItemID: Subscription<Int>]
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
        self.cartContentComponent = UINewListComponent()
        
        self.cartItemComponents = []
        
        self.storeCoordinator = UIStoreCoordinator()
        
        self.cartManager = CartManager()
        
        self.selectionSubscriptionMap = [:]
        
        self.quantitySubscriptionMap = [:]
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collapseBarController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(toggleCartContent)
        )
        
        cartManager.setDidChangeCart { [unowned self] descriptors in
            
            let totalAmount = descriptors.reduce(0.0) { currentResult, descriptor in
             
                if descriptor.isSelected {
                    
                    let quantity = Double(descriptor.quantity)
                    
                    return currentResult + (quantity * descriptor.item.price)
                    
                }
                
                return currentResult
                
            }
            
            self.cartCoordinator.setAmount(totalAmount)
            
        }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        setUpCartItemComponents()
        
        collapseBarController.setBarContentViewController(
            UIComponentViewController(component: cartContentComponent)
        )
        
        collapseBarController.setBarViewController(cartCoordinator.viewController)
        
        collapseBarController.setBackgroundViewController(storeCoordinator.viewController)
        
        cartContentComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { [unowned self] _ in self.cartItemComponents.count }
            .setComponentForItem { [unowned self] indexPath in
                
                return self.cartItemComponents[indexPath.row]
                
            }
            .render()
        
        cartCoordinator.activate()
        
        storeCoordinator
            .setDidSelectProduct { [unowned self] product in
                
                self.cartManager.setItem(
                    descriptor: CartItemDescriptor(
                        item: product,
                        quantity: 1,
                        isSelected: true
                    )
                )
                
                self.setUpCartItemComponents()
                
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
    
    fileprivate final func setUpCartItemComponents() {

        cartItemComponents = cartManager.itemDescriptors().map { descriptor in
        
            let cartManager = self.cartManager
            
            let item = descriptor.item
            
            let selectionComponent = UICheckboxComponent(inputValue: descriptor.isSelected)
            
            self.selectionSubscriptionMap[item.id] = selectionComponent.input.subscribe { _, isSelected in
                
                guard
                    var itemDescriptor = cartManager.itemDescriptor(id: item.id)
                else { return }
                
                itemDescriptor.isSelected = isSelected
                
                cartManager.setItem(descriptor: itemDescriptor)
                
            }
            
            let quantityComponent = UINumberPickerComponent(
                inputValue: descriptor.quantity,
                minimumValue: 1,
                maximumValue: 99
            )
            
            quantityComponent.setDidFail { error in
                
                // TODO: error handling.
                print("\(error)")
                
            }
            
            self.quantitySubscriptionMap[item.id] = quantityComponent.input.subscribe { _, quantity in
                
                guard
                    var itemDescriptor = cartManager.itemDescriptor(id: item.id)
                else { return }
                
                itemDescriptor.quantity = quantity
                
                cartManager.setItem(descriptor: itemDescriptor)
                
            }
            
            let optionChainComponent = UIOptionChainComponent()
            
            optionChainComponent.setOptionDescriptors(
                [
                    UIOptionDescriptor(
                        title: NSLocalizedString(
                            "Edit",
                            comment: ""
                        ),
                        handler: { print("Edit") }
                    ),
                    UIOptionDescriptor(
                        title: NSLocalizedString(
                            "Delete",
                            comment: ""
                        ),
                        handler: { print("Delete") }
                    )
                ]
            )
            
            let component = UICartItemComponent(
                selectionComponent: selectionComponent,
                quantityComponent: quantityComponent,
                optionChainComponent: optionChainComponent
            )
                
            component.setTitle(item.title).setPrice(item.price)
            
            // Prevent the presenting child components get deallocated.
            self.cartItemComponents.append(component)
            
            // TODO: emulate image downloading process.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                component.setPreviewImages(
                    [ #imageLiteral(resourceName: "image-dessert-1") ]
                )
                
            }
            
            return component
            
        }
        
    }
    
    // MARK: Action
    
    @objc
    public final func toggleCartContent(_ sender: Any) {
        
        collapseBarController.setCollapsed(
            !collapseBarController.isCollapsed,
            animated: true
        )
        
    }
    
    public typealias ShowProductDetailHandler = (_ viewController: UIViewController) -> Void
    
    private final var showProductDetailHandler: ShowProductDetailHandler?
    
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
