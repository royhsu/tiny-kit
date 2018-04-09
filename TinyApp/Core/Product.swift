//
//  Product.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Product

import Foundation

public struct Product {

    public let id: String

    public let imageURLs: [URL]

    public let title: String

    public let price: Double

    public init(
        id: String,
        imageURLs: [URL],
        title: String,
        price: Double
    ) {

        self.id = id

        self.imageURLs = imageURLs

        self.title = title

        self.price = price

    }

}
