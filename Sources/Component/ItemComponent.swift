//
//  ItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponent

import TinyCore

public final class ItemComponent<
    V: View,
    M: Codable
>: Component {
    
    /// The underlying view that preserves the type information.
    internal final let itemView: V
    
    public final var model: M
    
    public typealias Binding = (V, M) -> Void
    
    private final let binding: Binding
    
    public init(
        contentMode: ComponentContentMode,
        view: V,
        model: M,
        binding: @escaping Binding
    ) {
        
        self.contentMode = contentMode
        
        self.itemView = view
        
        self.model = model
        
        self.binding = binding
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemView }
    
    public final var preferredContentSize: CGSize { return itemView.bounds.size }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode

    public final func render() -> Promise<Void> {
        
        return Promise(in: .main) { fulfill, _, _ in
            
            DispatchQueue.main.async {
            
                switch self.contentMode {
                    
                case .size(let width, let height):
                    
                    var frame = self.itemView.frame
                    
                    frame.size = CGSize(
                        width: width,
                        height: height
                    )
                    
                    self.itemView.frame = frame
                    
                case .automatic:
                    
                    self.itemView.layoutIfNeeded()
                    
                }
                
                self.binding(
                    self.itemView,
                    self.model
                )
                
                let result: Void = ()
                
                fulfill(result)
                
            }
            
        }
        
    }
    
}
