//
//  TPPostComponent+UIListComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 2018/4/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostComponent

public extension TPPostComponent {
    
    public convenience init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.init(
            layoutComponent: UIListComponent(contentMode: contentMode)
        )
        
    }
    
}

// MARK: - ExpressibleByArrayLiteral

extension TPPostComponent: ExpressibleByArrayLiteral {
    
    public convenience init(arrayLiteral elements: Element...) {
        
        self.init()
        
        self.setElements(elements)
        
    }
    
}
