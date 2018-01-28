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
    private final let _view: V
    
    /// Changing the model will also automatically reflect to the bond view.
    public final var model: M {
        
        didSet {
            
            binding(
                _view,
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
        
        self._view = view
        
        self.model = model
        
        self.binding = binding
        
        super.init()
        
        preferredContentSize = _view.bounds.size
        
        binding(
            _view,
            model
        )
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return _view }
    
    public final var preferredContentSize: CGSize {
    
        get { return _view.bounds.size }
    
        set {
    
            var preferredFrame = _view.frame
    
            preferredFrame.size = newValue
    
            _view.frame = preferredFrame
    
        }
    
    }

}
