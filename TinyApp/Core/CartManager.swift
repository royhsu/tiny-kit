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
    
    public final let cart: Observable<[CartItemDescriptor]>
    
    public init() {
        
        self.cart = Observable(
            []
        )
        
    }
    
}

public extension CartManager {
    
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
    
}
