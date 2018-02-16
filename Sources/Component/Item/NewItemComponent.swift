//
//  NewItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NewItemComponent

public protocol NewItemComponent: Component {
    
    associatedtype ItemView: View
    
    var itemView: ItemView { get }
    
}

// MARK: - ViewRenderable (Default Implementation)

public extension NewItemComponent {
    
    public var view: View { return itemView }
    
    public var preferredContentSize: CGSize { return itemView.bounds.size }
    
}
