//
//  Section.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SectionCollection

import TinyCore

public protocol SectionCollection: Emptible {
    
    typealias NewSection = ViewCollection
    
    var count: Int { get }
    
    subscript(index: Int) -> NewSection { get }
    
}

extension SectionCollection {
    
    public var isEmpty: Bool { return (count == 0) }
    
}
