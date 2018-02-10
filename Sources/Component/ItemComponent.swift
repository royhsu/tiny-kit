//
//  ItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponent

import TinyCore

/// Implementing a custom component by overriding this class.
/// Be sure to initiatie and manipulate it only in the main thread.
open class ItemComponent<
    V: View,
    M: Codable
>: Component {
    
    /// The underlying view preserve the type information.
    public final let itemView: V
    
    public final var model: M
    
    public typealias Binding = (V, M) -> Void
    
    private final let binding: Binding
    
    public init(
        view: V,
        model: M,
        binding: @escaping Binding
    ) {
        
        self.itemView = view
        
        self.model = model
        
        self.binding = binding
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemView }
    
    public final var preferredContentSize: CGSize { return itemView.bounds.size }
    
    // MARK: Component

    public final func render() -> Promise<Void> {
        
        return Promise(in: .main) { fulfill, _, _ in
            
            self.binding(
                self.itemView,
                self.model
            )
            
            let result: Void = ()
            
            fulfill(result)
            
        }
        
    }
    
}
