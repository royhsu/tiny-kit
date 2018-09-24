//
//  Section.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SectionCollection

public protocol SectionCollection {
    
    typealias Section = Template
    
    var count: Int { get }
    
    func section(at index: Int) -> Section
    
}

public extension SectionCollection {
    
    public var isEmpty: Bool { return (count == 0) }
    
}
