//
//  Product.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Product

import TinyKit

public struct Product {

    public let id: String

    public let imageContainers: [ImageResource]

    public let title: String

    public let price: Double

    public init(
        id: String,
        imageContainers: [ImageResource],
        title: String,
        price: Double
    ) {

        self.id = id

        self.imageContainers = imageContainers

        self.title = title

        self.price = price

    }

}
