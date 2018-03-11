//
//  ComponentGroup.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentGroup

public protocol ComponentGroup {
    
    func numberOfSections() -> Int
    
    func numberOfItems(inSection section: Int) -> Int
    
    func componentForItem(at indexPath: IndexPath) -> Component
    
}
