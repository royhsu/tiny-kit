//
//  CartItem.swift
//  TinyApp
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CartItem

import Foundation

public protocol CartItem {
    
    var id: String { get }
    
    var imageURLs: [URL] { get }
    
    var title: String { get }
    
    var price: Double { get }
    
}
