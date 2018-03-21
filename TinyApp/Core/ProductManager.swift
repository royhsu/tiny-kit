//
//  ProductManager.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductManager

import Foundation
import Hydra

public final class ProductManager {
    
    public init() { }
    
    public final func fetchProducts(in context: Context) -> Promise<[Product]> {
        
        return Promise(in: context) { fulfill, reject, _ in
            
            let products = [
                Product(
                    id: UUID().uuidString,
                    imageURLs: [],
                    title: "Cras mattis consectetur purus sit amet fermentum.",
                    price: 40.0
                ),
                Product(
                    id: UUID().uuidString,
                    imageURLs: [],
                    title: "Aenean eu leo quam.",
                    price: 120.0
                ),
                Product(
                    id: UUID().uuidString,
                    imageURLs: [],
                    title: "Donec id elit non mi porta gravida at eget metus.",
                    price: 75.0
                )
            ]
            
            fulfill(products)
            
        }
        
    }
    
}

