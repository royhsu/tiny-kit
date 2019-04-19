//
//  PaginationController+Cache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Cache

import TinyCore

extension PaginationController {
    
    final class Cache {
        
        let elementStates = Property<[ElementState<Element>]>()
        
        var currentPagesElementStateIndices: [Int] = []
        
        var previousPageElementStateIndices: [Int]?
        
        var nextPageElementStateIndices: [Int]?
        
        init() { }
        
        func update(with storage: PageStorage<Element, Cursor>?) {
            
            let result = storage?.reduce()
            
            self.elementStates.modify {
                
                $0 = result?.elementStates ?? []
            
                self.currentPagesElementStateIndices = result?.currentPagesElementStateIndices ?? []
            
                self.previousPageElementStateIndices = result?.previousPageElementStateIndices
            
                self.nextPageElementStateIndices = result?.nextPageElementStateIndices
                
            }
            
        }
        
    }
        
}
