//
//  PrefetchPage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchPage

enum PrefetchPage {
    
    case previous, next
    
}

// MARK: - Equatable

extension PrefetchPage: Equatable { }

extension PrefetchPage: CustomDebugStringConvertible {
    
    var debugDescription: String {
        
        switch self {
            
        case .previous: return ".previous"
            
        case .next: return ".next"
            
        }
        
    }
    
}
