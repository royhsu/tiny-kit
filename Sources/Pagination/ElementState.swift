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
