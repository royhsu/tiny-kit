//
//  Section.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SectionCollection

public protocol SectionCollection {
    
    associatedtype Section: Template
    
    var count: Int { get }
    
    func section(at index: Int) -> Section
    
}

public extension SectionCollection {
    
    public var isEmpty: Bool { return (count == 0) }
    
}

// MARK: - AnySectionCollection

public struct AnySectionCollection<Section>: SectionCollection where Section: Template {
    
    private let _count: () -> Int
    
    private let _section: (_ index: Int) -> Section
    
    init<S>(_ section: S)
    where
        S: SectionCollection,
        S.Section == Section
    {
        
        self._count = { section.count }
        
        self._section = section.section
            
    }
    
    public var count: Int { return _count() }
    
    public func section(at index: Int) -> Section { return _section(index) }
    
}
