//
//  ComponentCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentCollection

public protocol ComponentCollection {
    
    func numberOfSections() -> Int
    
    func numberOfItems(inSection section: Int) -> Int
    
    func componentForItem(at indexPath: IndexPath) -> Component
    
}
