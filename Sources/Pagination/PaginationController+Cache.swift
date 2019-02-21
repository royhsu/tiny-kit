//
//  PaginationController+Cache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Cache

extension PaginationController {
    
    struct Cache {
        
        var elementStates: [ElementState<Element>]
        
        var currentPagesElementStateIndices: [Int]
        
        var previousPageElementStateIndices: [Int]?
        
        var nextPageElementStateIndices: [Int]?
        
        init(storage: PageStorage<Element, Cursor>? = nil) {
            
            let result = storage?.reduce()
            
            self.elementStates = result?.elementStates ?? []
            
            self.currentPagesElementStateIndices = result?.currentPagesElementStateIndices ?? []
            
            self.previousPageElementStateIndices = result?.previousPageElementStateIndices
            
            self.nextPageElementStateIndices = result?.nextPageElementStateIndices
            
        }
        
    }
        
}
