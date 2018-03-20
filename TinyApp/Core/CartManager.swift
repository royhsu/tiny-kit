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
