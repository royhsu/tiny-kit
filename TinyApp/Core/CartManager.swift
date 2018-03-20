//
//  CartManager.swift
//  TinyApp
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CartManager

import TinyKit

public final class CartManager {
    
    private final let cart: Observable<[CartItemDescriptor]>
    
    private final var cartSubscription: Subscription<[CartItemDescriptor]>?
    
    public init() {
        
        self.cart = Observable(
            []
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        cartSubscription = cart.subscribe { [unowned self] _, descriptors in
            
            self.didChangeCartHandler?(descriptors)
            
        }
        
    }
    
    // MARK: Action
 
    public typealias DidChangeCartHandler = ([CartItemDescriptor]) -> Void
    
    private final var didChangeCartHandler: DidChangeCartHandler?
    
}

public extension CartManager {
    
    public struct AmountOptions: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) { self.rawValue = rawValue }
        
        public static let selectedOnly: AmountOptions = .init(rawValue: 1 << 0)
        
        public static let unselectedOnly: AmountOptions = .init(rawValue: 1 << 1)
        
        public static let all: AmountOptions = [ .selectedOnly, .unselectedOnly ]
        
    }
    
    // Get the total amount of the current cart.
    public final func amount(options: AmountOptions = .all) -> Double {
        
        let descriptors: [CartItemDescriptor]
        
        switch options {
            
        case .selectedOnly: descriptors = cart.value.filter { $0.isSelected }
            
        case .unselectedOnly: descriptors = cart.value.filter { !$0.isSelected }
            
        case .all: descriptors = cart.value
            
        default: fatalError("Unsupported options for calculation.")
            
        }
        
        return descriptors.reduce(0.0) { currentAmount, descriptor in
            
            let quantity = Double(descriptor.quantity)
            
            return currentAmount + (quantity * descriptor.item.price)
            
        }
        
    }
    
    public final func itemDescriptors() -> [CartItemDescriptor] { return cart.value }
    
    // Add an item to the cart if the cart doesn't contain it.
    // Update the existing item in the cart if the cart contains it.
    public final func setItem(descriptor: CartItemDescriptor) {
        
        guard
            let index = cart.value.index(
                where: { $0.item.id == descriptor.item.id }
            )
        else { cart.value.append(descriptor); return }
        
        cart.value[index].quantity = descriptor.quantity
        
        cart.value[index].isSelected = descriptor.isSelected
        
    }
    
    public final func itemDescriptor(id: String) -> CartItemDescriptor? {
        
        guard
            let index = cart.value.index(
                where: { $0.item.id == id }
            )
        else { return nil }
        
        return cart.value[index]
        
    }
    
    // Remove the item from the cart with the given id.
    public final func removeItem(withId id: String) {
        
        guard
            let index = cart.value.index(
                where: { $0.item.id == id }
            )
        else { return }
        
        cart.value.remove(at: index)
        
    }
 
    @discardableResult
    public final func setDidChangeCart(_ handler: DidChangeCartHandler?) -> CartManager {
        
        didChangeCartHandler = handler
        
        return self
        
    }
    
}
