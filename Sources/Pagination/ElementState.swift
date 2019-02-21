//
//  ElementState.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - ElementState

public enum ElementState<Element> {
    
    case inactive
    
    case fetching
    
    case fetched(Element)
    
    case error
    
}

// MARK: - Equatable

extension ElementState: Equatable where Element: Equatable { }

// MARK: - CustomDebugStringConvertible

extension ElementState: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        
        switch self {
            
        case .inactive: return ".inactive."
            
        case .fetching: return ".fetching"
            
        case let .fetched(element): return ".fetched(\(element))"
            
        case .error: return ".error"
            
        }
        
    }
    
}
