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

public protocol CartItem {
    
    var id: String { get }
    
    var imageURLs: [URL] { get }
    
    var title: String { get }
    
    var price: Double { get }
    
}

public struct CartItemDescriptor {
    
    public let item: CartItem
    
    public var quantity: Int

    public var isSelected: Bool
    
    public init(
        item: CartItem,
        quantity: Int,
        isSelected: Bool
    ) {
        
        self.item = item
        
        self.quantity = quantity
        
        self.isSelected = isSelected
        
    }
    
}

extension Product: CartItem { }
