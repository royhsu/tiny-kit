//
//  ComponentViewModel.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentViewModel

public struct ComponentViewModel<
    View: UIView,
    Model: Codable
> {
    
    public typealias Binding = (View, Model) -> Void
    
    public let view: View
    
    public var model: Model {
        
        didSet {
            
            binding(
                view,
                model
            )
            
        }
        
    }
    
    private let binding: Binding
    
    public init<Factroy: ViewFactory>(
        viewFactory: Factroy,
        model: Model,
        binding: @escaping Binding
    )
    where Factroy.View == View {
        
        let view = viewFactory.makeView()
        
        self.view = view
        
        self.model = model
        
        self.binding = binding
        
        binding(
            view,
            model
        )
        
    }
    
}
