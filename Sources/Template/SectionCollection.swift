//
//  Section.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SectionCollection

public protocol SectionCollection {
    
    // Rename with Section
    associatedtype Item: SectionItem
    
//    associatedtype Value
    
//    var storage: AnyStorage<Int, Value> { get }
    
    var numberOfItems: Int { get }
    
    func item(at index: Int) -> Item
    
}

// MARK: - AnySectionCollection

public struct AnySectionCollection<Item>: SectionCollection where Item: SectionItem {
    
//    private let _storage: () -> AnyStorage<Int, Value>
    
    private let _numberOfItems: () -> Int
    
    private let _item: (_ index: Int) -> Item
    
    init<S>(_ section: S)
    where
        S: SectionCollection,
        S.Item == Item
//        S.Value == Value
    {
        
//            self._storage = { section.storage }
        
        self._numberOfItems = { section.numberOfItems }
        
        self._item = section.item
            
    }
    
//    public var storage: AnyStorage<Int, Value> { return _storage() }
    
    public var numberOfItems: Int { return _numberOfItems() }
    
    public func item(at index: Int) -> Item { return _item(index) }
    
}
