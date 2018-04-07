//
//  UICartCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartCoordinator

import TinyCore
import TinyKit
import TinyStore
import TinyUI

public final class UICartCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    private final let cartBarComponent: UICartBarComponent
    
    private final let cartContentComponent: ListComponent
    
    private final let homeCoordinator: UIHomeCoordinator
    
    // TODO:
    // 1. wishlist cart manager in home
    // 2. checkout cart manager in checkout process
    private final let cartManager: CartManager
    
    public typealias ItemID = String
    
    private typealias Selection = Observable<Bool>
    
    private final var selectionSubscriptionMap: [ItemID: Selection.ValueDidChangeSubscription]
    
    private typealias Quantity = Observable<Int>
    
    private final var quantitySubscriptionMap: [ItemID: Quantity.ValueDidChangeSubscription]
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartBarComponent = UICartBarComponent()
        
        self.cartContentComponent = UIListComponent()
        
        self.homeCoordinator = UIHomeCoordinator()
        
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
        
        homeCoordinator.setAddToCart { [unowned self] product in
            
            self.cartManager.setItem(
                descriptor: CartItemDescriptor(
                    item: product,
                    quantity: 1,
                    isSelected: true
                )
            )
            
        }
        
        cartManager.setDidChangeCart { [unowned self] _ in
            
            let amount = self.cartManager.amount(options: .selectedOnly)
            
            self.cartBarComponent.setAmount(amount)
            
        }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        setUpCartItemComponents()
        
        collapseBarController.setBarContentViewController(
            UIComponentViewController(component: cartContentComponent)
        )
        
        collapseBarController.setBarViewController(
            UIComponentViewController(component: cartBarComponent)
        )
        
        collapseBarController.setBackgroundViewController(homeCoordinator.viewController)
        
        cartContentComponent.render()
        
        homeCoordinator.activate()
        
    }
    
    fileprivate final func setUpCartItemComponents() {

       let components: [Component] = cartManager.itemDescriptors().map { descriptor in
        
            let cartManager = self.cartManager
            
            let item = descriptor.item
            
            let selectionComponent = UICheckboxComponent(inputValue: descriptor.isSelected)
            
            self.selectionSubscriptionMap[item.id] = selectionComponent.input.observeValueDidChange { _, isSelected in
                
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
            
            self.quantitySubscriptionMap[item.id] = quantityComponent.input.observeValueDidChange { _, quantity in
                
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
            
            // TODO: emulate image downloading process.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                component.setPreviewImages(
                    [ #imageLiteral(resourceName: "image-dessert-1") ]
                )
                
            }
            
            return component
            
        }
        
        cartContentComponent.setItemComponents(components)
        
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

public extension UICartCoordinator {
    
    @discardableResult
    public final func setShowProductDetail(_ handler: ShowProductDetailHandler?) -> UICartCoordinator {
        
        showProductDetailHandler = handler
        
        return self
        
    }

}

// MARK: - ViewControllerRepresentable

extension UICartCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
