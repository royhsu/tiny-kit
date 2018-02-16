//
//  TKItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TKItemComponent

public final class TKItemComponent<V: View>: NewItemComponent {
    
    public typealias ItemView = V
    
    public final let itemView: ItemView
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        itemView: ItemView
    ) {
        
        self.contentMode = contentMode
        
        self.itemView = itemView
        
    }
    
    // MARK: ViewRenderable
    
    public final let view = View()
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        itemView.removeFromSuperview()
        
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(itemView)
        
        NSLayoutConstraint.activate(
            [
                view
                    .leadingAnchor
                    .constraint(equalTo: itemView.leadingAnchor),
                view
                    .topAnchor
                    .constraint(equalTo: itemView.topAnchor),
                view
                    .trailingAnchor
                    .constraint(equalTo: itemView.trailingAnchor)
            ]
        )
        
        let size: CGSize
        
        switch contentMode {
            
        case .size(let width, let height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic:
            
            itemView.layoutIfNeeded()
            
            size = itemView.bounds.size
            
        }
        
        view.frame.size = size
        
        itemView.frame.size = size
        
        NSLayoutConstraint.activate(
            [
                view
                    .bottomAnchor
                    .constraint(equalTo: itemView.bottomAnchor)
            ]
        )
        
    }
    
}
