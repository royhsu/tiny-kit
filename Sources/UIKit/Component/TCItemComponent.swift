//
//  TCItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/15.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TCItemComponent

public final class TCItemComponent<ItemView: View> {
    
    public final let itemView: ItemView
    
    public init(itemView: ItemView) { self.itemView = itemView }
    
    // MARK: Component
    
    public final func render() { }
    
}
