//
//  Group.swift
//  TinyKit
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Group

public struct Group<Item>: Collection {

    private var storage: Storage = [:]
    
    public init(_ storage: Storage) { self.storage = storage }
    
    // MARK: Collection
    
    public typealias Index = Storage.Index
    
    public typealias Element = Storage.Element
    
    public var startIndex: Index { return storage.startIndex }
    
    public var endIndex: Index { return storage.endIndex }
    
    public subscript(_ index: Index) -> Element { return storage[index] }
    
    public func index(after i: Index) -> Index { return storage.index(after: i) }
    
    // MARK: Group
    
    public enum GroupIndex {
        
        case header, body, footer
        
    }
    
    // MARK: Storage
    
    public typealias Storage = [GroupIndex: Array<Item>]
    
//    public typealias Index = Group
    
//    public var header: [Element]
//
//    public var body: [Element]
//
//    public var footer: [Element]
//
//    public init(
//        header: [Element],
//        body: [Element],
//        footer: [Element]
//    ) {
//
//        self.header = header
//
//        self.body = body
//
//        self.footer = footer
//
//    }
    
}
