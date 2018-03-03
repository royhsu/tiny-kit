//
//  StubItemComponents.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StubItemComponents

import TinyKit

internal class StubItemComponents: ListItemComponents {
    
    private final let _numberOfSections: () -> Int
    
    private final let _numberOfItemsInSection: (_ section: Int) -> Int
    
    private final let _componentAtItem: (_ indexPath: IndexPath) -> Component
    
    public init(
        numberOfSections: @escaping () -> Int,
        numberOfItemsInSection: @escaping (_ section: Int) -> Int,
        componentAtItem: @escaping (_ indexPath: IndexPath) -> Component
    ) {
        
        self._numberOfSections = numberOfSections
        
        self._numberOfItemsInSection = numberOfItemsInSection
        
        self._componentAtItem = componentAtItem
        
    }
    
    internal final func numberOfSections() -> Int { return _numberOfSections() }
    
    internal final func numberOfItemsAtSection(_ section: Int) -> Int { return _numberOfItemsInSection(section) }
    
    internal final func componentForItem(at indexPath: IndexPath) -> Component { return _componentAtItem(indexPath) }
    
}
