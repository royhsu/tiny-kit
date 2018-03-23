//
//  CollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionComponent

public protocol CollectionComponent: Component {
    
    typealias ComponentGroup = AnyIndexableGroup<Component>
    
    var itemComponentGroup: ComponentGroup { get }
    
    @discardableResult
    func setItemComponentGroup(_ group: ComponentGroup) -> Self
    
}

public extension CollectionComponent {
    
    @discardableResult
    public func setItem(
        components: [Component]
    )
    -> Self {
        
        return setItemComponentGroup(
            AnyIndexableGroup(components)
        )
            
    }
    
}
