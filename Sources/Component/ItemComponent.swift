//
//  ItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponent

public final class ItemComponent<
    V: View,
    M: Codable
>: ComponentNode, Component {
    
    /// The underlying view contains its type information.
    public final let itemView: V
    
    /// Changing the model will also automatically reflect to the bond item view.
    public final var model: M {
        
        didSet {
            
            binding(
                itemView,
                model
            )
            
        }
        
    }
    
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
        
        self.preferredContentSize = itemView.bounds.size
        
        super.init()
        
        binding(
            itemView,
            model
        )
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemView }
    
    public final var preferredContentSize: CGSize {
        
        didSet {
            
            var preferredFrame = itemView.frame
            
            preferredFrame.size = preferredContentSize
            
            itemView.frame = preferredFrame
            
        }
        
    }

}
