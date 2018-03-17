//
//  Product.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Product

public struct Product {
    
    public let title: String
    
    public let price: Double
    
    public init(
        title: String,
        price: Double
    ) {
        
        self.title = title
        
        self.price = price
        
    }
    
}
