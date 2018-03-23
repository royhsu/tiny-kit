//
//  Array+IndexableGroup.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - IndexableGroup

extension Array: IndexableGroup {
    
    public var numberOfSections: Int { return 1 }
    
    public func numberOfElements(inSection section: Int) -> Int { return count }
    
    public func element(at indexPath: IndexPath) -> Element { return self[indexPath.item] }
    
}
