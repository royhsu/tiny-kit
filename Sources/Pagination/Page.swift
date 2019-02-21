//
//  Page.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Page

public struct Page<Element, Cursor> {
    
    public let elements: [Element]
    
    public let previousPageCursor: Cursor?
    
    public let nextPageCursor: Cursor?
    
    public init(
        elements: [Element] = [],
        previousPageCursor: Cursor? = nil,
        nextPageCursor: Cursor? = nil
    ) {
        
        self.elements = elements
        
        self.previousPageCursor = previousPageCursor
        
        self.nextPageCursor = nextPageCursor
        
    }
    
}

// MARK: - Page

extension Page: Equatable where Element: Equatable, Cursor: Equatable { }
