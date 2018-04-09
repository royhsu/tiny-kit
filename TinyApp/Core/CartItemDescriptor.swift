//
//  CartItemDescriptor.swift
//  TinyApp
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CartItemDescriptor

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
