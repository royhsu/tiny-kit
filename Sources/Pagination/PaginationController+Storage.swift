//
//  PaginationController+Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Storage

extension PaginationController {
    
    #warning("TODO: add unit tests.")
    class Storage {
        
        private let _elementStates = Atomic(value: [ElementState]() )
        
        var elementStatesDidChange: ( () -> Void )?
        
        var elementStates: [ElementState] {
            
            get { return _elementStates.value }
            
            set {
                
                _elementStates.mutateValue { $0 = newValue }
                
                self.elementStatesDidChange?()
                
            }
            
        }
        
    }
    
}
