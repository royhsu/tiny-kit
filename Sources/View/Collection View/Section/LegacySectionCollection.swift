//
//  LegacySectionCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacySectionCollection

@available(*, deprecated: 1.0, renamed: "SectionCollection")
public protocol LegacySectionCollection {
    
    typealias Section = LegacyViewCollection
    
    var count: Int { get }
    
    func section(at index: Int) -> Section
    
}

public extension LegacySectionCollection {
    
    public var isEmpty: Bool { return (count == 0) }
    
}

extension Array: LegacySectionCollection where Element == LegacyViewCollection {
    
    public func section(at index: Int) -> Section { return self[index] }
    
}
