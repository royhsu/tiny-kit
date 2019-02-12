//
//  PaginationController+ElementState.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - ElementState

extension PaginationController {
    
    enum ElementState {
        
        case fetching
        
        case fetched(Element)
        
        case error
        
    }
    
}

// MARK: - Equatable

extension PaginationController.ElementState: Equatable where Element: Equatable { }
