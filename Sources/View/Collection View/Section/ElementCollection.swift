//
//  ElementCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ElementCollection

public struct ElementCollection<Element>: ExpressibleByArrayLiteral {
    
    private var elements: [Element]
    
    public init<C: Collection>(_ collection: C)
        where
        C.Element == Element,
        C.Index == Int
    { self.elements = Array(collection) }
    
    public init(arrayLiteral elements: Element...) { self.init(elements) }
    
    public init() { self.init([]) }
    
}

// MARK: -  Collection

extension ElementCollection: Collection {
    
    public var startIndex: Int { return elements.startIndex }
    
    public var endIndex: Int { return elements.endIndex }
    
    public func index(after i: Int) -> Int { return elements.index(after: i) }
    
    public subscript(index: Int) -> Element { return elements[index] }
    
}

// MARK: - Emptible

extension ElementCollection: Emptible {
    
    public var isEmpty: Bool { return elements.isEmpty }
    
}

// MARK: - NewSectionCollection

extension ElementCollection: NewSectionCollection where Element: NewViewCollection {
    
    public subscript(index: Int) -> NewSection { return elements[index] }
    
}
