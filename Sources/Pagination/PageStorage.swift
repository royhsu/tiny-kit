//
//  PageStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/13.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PageStorage

struct PageStorage<Element, Cursor> {
    
    var currentPages: [Page<Element, Cursor>]
    
    var previousPage: StatefulPage<Cursor>?
    
    var nextPage: StatefulPage<Cursor>?
    
    init(
        currentPages: [Page<Element, Cursor>] = [],
        previousPage: StatefulPage<Cursor>? = nil,
        nextPage: StatefulPage<Cursor>? = nil
    ) {
        
        self.currentPages = currentPages
        
        self.previousPage = previousPage
        
        self.nextPage = nextPage
        
    }
    
}

extension PageStorage {
    
    var hasPreviousPage: Bool { return previousPage != nil }
    
    var hasNextPage: Bool { return nextPage != nil }
    
}

extension PageStorage {
    
    func reduce() -> (
        elementStates: [ElementState<Element>],
        currentPagesElementStateIndices: [Int],
        previousPageElementStateIndices: [Int]?,
        nextPageElementStateIndices: [Int]?
    ) {
        
        var elementStateCount = 0
        
        let previousStates = parseElementStates(for: previousPage)
        
        var previousPageElementStateIndices: [Int]?
            
        if !previousStates.isEmpty {
            
            previousPageElementStateIndices = previousStates.indices.map { $0 + elementStateCount }
            
            elementStateCount += previousStates.count
            
        }
        
        let currentStates: [ElementState] = currentPages.reduce( [] ) { result, page in
            
            return result + page.elements.map { .fetched($0) }
            
        }
        
        let currentPagesElementStateIndices = currentStates.indices.map { $0 + elementStateCount }
        
        elementStateCount += currentStates.count
        
        let nextStates = parseElementStates(for: nextPage)
        
        var nextPageElementStateIndices: [Int]?
        
        if !nextStates.isEmpty {
            
            nextPageElementStateIndices = nextStates.indices.map { $0 + elementStateCount }
            
            elementStateCount += nextStates.count
            
        }
        
        return (
            previousStates + currentStates + nextStates,
            currentPagesElementStateIndices,
            previousPageElementStateIndices,
            nextPageElementStateIndices
        )
        
    }
    
    private func parseElementStates(for page: StatefulPage<Cursor>?) -> [ElementState<Element>] {
        
        guard let page = page else { return [] }
            
        let state: ElementState<Element>
        
        switch page.state {
            
        case .inactive: state = .inactive
            
        case .fetching: state = .fetching
            
        }
        
        return Array(
            repeating: state,
            count: page.elementCount
        )
        
    }
    
}
