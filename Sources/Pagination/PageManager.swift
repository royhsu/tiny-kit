//
//  PageManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/13.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PageManager

final class PageManager<Element, Cursor> {
    
    private let currentPages: [Page<Element, Cursor>]
    
    private let previousPage: InactivePage<Cursor>?
    
    private let nextPage: InactivePage<Cursor>?
    
    init(
        currentPages: [Page<Element, Cursor>] = [],
        previousPage: InactivePage<Cursor>? = nil,
        nextPage: InactivePage<Cursor>? = nil
    ) {
        
        self.currentPages = currentPages
        
        self.previousPage = previousPage
        
        self.nextPage = nextPage
        
    }
    
}

extension PageManager {
    
    var hasPreviousPage: Bool { return previousPage != nil }
    
    var hasNextPage: Bool { return nextPage != nil }
    
}

extension PageManager {
    
    typealias ElementState = PaginationController<Element, Cursor>.ElementState
    
    var elementStates: [ElementState] {
        
        let currentStates: [ElementState] = currentPages.reduce( [] ) { result, page in
            
            return result + page.elements.map { .fetched($0) }
            
        }
        
        let previousStates: [ElementState] = Array(
            repeating: .inactive,
            count: previousPage?.elementCount ?? 0
        )
        
        let nextStates: [ElementState] = Array(
            repeating: .inactive,
            count: nextPage?.elementCount ?? 0
        )
        
        return previousStates + currentStates + nextStates
        
    }
    
}
