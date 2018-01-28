//
//  ItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponent

public class ItemComponent<
    View: UIView,
    Model: Codable
>: ComponentNode, Component {
    
    public typealias ViewModel = ComponentViewModel<View, Model>
    
    private final let viewModel: ViewModel
    
    public init(
        preferredContentSize: CGSize,
        viewModel: ViewModel
    ) {
        
        self.preferredContentSize = preferredContentSize
        
        self.viewModel = viewModel
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: UIView { return viewModel.view }
    
    public final var preferredContentSize: CGSize

}
